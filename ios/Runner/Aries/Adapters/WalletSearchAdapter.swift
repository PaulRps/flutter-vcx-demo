//
//  WalletSearchAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine
import vcx

class WalletSearchAdapter: WalletSearchPort, CheckVcxResult {
    private final let logger = CustomLogger(context: WalletSearchAdapter.self)
    private var cancellables: Set<AnyCancellable>
    private final let vcx: ConnectMeVcx

    init() {
        self.vcx = ConnectMeVcx()
        self.cancellables = Set()
    }

    func search(
            query: WalletQueryDto,
            count: NSInteger = 100
    ) -> Future<SearchWalletResponseDto, Error> {
        return Future { promise in
            var searchHandle = 0
            var queryResult = SearchWalletResponseDto()

            self.logger.info(message: "searching record in wallet with query \(query.toJson())")

            self.openSearch(query: query)
                    .map { handle in
                        searchHandle = handle
                    }
                    .flatMap({
                        self.searchNextRecords(searchHandle: searchHandle, count: count)
                    })
                    .map { records in
                        queryResult = records
                        _ = self.closeSearch(searchHandle: searchHandle)
                    }
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on searching wallet: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    }, receiveValue: { _ in

                        self.logger.info(message: "finished searching in wallet with result: \(queryResult.toJson())")

                        promise(.success(queryResult))
                    })
                    .store(in: &self.cancellables)
        }
    }

    private func openSearch(query: WalletQueryDto) -> Future<NSInteger, Error> {
        return Future { promise in
            self.logger.info(message: "opening search in wallet")
            self.vcx.openSearchWallet(
                    query.type!,
                    queryJson: query.json,
                    optionsJson: query.optionsTag?.toJson(),
                    completion: { error, handle in
                        if self.isFail(error) {
                            self.logger.error(message: "error on opening search in wallet: \(error!.localizedDescription)")
                            promise(.failure(error!))
                            return
                        }

                        self.logger.info(message: "opened search in wallet successfully")
                        promise(.success(handle))
                    })
        }
    }

    private func searchNextRecords(searchHandle: NSInteger, count: NSInteger) -> Future<SearchWalletResponseDto, Error> {
        return Future { promise in
            self.logger.info(message: "searching next \(count) records in wallet")
            self.vcx.searchNextRecordsWallet(
                    searchHandle,
                    count: Int32(count),
                    completion: { error, recordsJson in
                        if self.isFail(error) {
                            self.logger.error(message: "error on searching next \(count) records in wallet: \(error!.localizedDescription)")
                            promise(.failure(error!))
                            return
                        }

                        let records = JsonUtil.fromJson(recordsJson ?? "", SearchWalletResponseDto.self)

                        self.logger.info(message: "searched next \(count) records in wallet with result: \(records?.toJson())")
                        promise(.success(records ?? SearchWalletResponseDto()))
                    })
        }
    }

    private func closeSearch(searchHandle: NSInteger) -> Future<Bool, Error> {
        return Future { promise in
            self.logger.info(message: "closing search in wallet")
            self.vcx.closeSearchWallet(searchHandle, completion: { error in
                if self.isFail(error) {
                    self.logger.error(message: "error on closing search in wallet: \(error!.localizedDescription)")
                    promise(.failure(error!))
                    return
                }

                self.logger.info(message: "closed search in wallet successfully")
                promise(.success(true))
            })
        }
    }

}
