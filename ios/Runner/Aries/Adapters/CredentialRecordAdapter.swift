//
// Created by Paulo Silva on 05/09/22.
//

import Foundation
import Combine

class CredentialRecordAdapter: CredentialRecordPort {
    private final let logger = CustomLogger(context: CredentialRecordAdapter.self)
    private final let walletRecordPort: WalletRecordAdapter
    private final let walletSearchPort: WalletSearchAdapter
    private var cancellables: Set<AnyCancellable>

    init(
            walletRecordPort: WalletRecordAdapter = WalletRecordAdapter(),
            walletSearchPort: WalletSearchAdapter = WalletSearchAdapter()
    ) {
        self.walletRecordPort = walletRecordPort
        self.walletSearchPort = walletSearchPort
        self.cancellables = Set()
    }

    func search(_ keyValQuery: Array<String>) -> Future<SearchWalletResponseDto, Error> {
        let queryJson = WalletTagsBuilder.Builder().encrypted(keyValQuery).build()

        self.logger.info(message: "searching aries credential record with query: \(queryJson)")

        return self.walletSearchPort.search(
                query: WalletQueryDto(
                        type: WalletRecordTypeEnum.CREDENTIAL.value,
                        json: queryJson
                ),
                count: 100
        )
    }

    func save(value: String, tag: WalletTagsBuilder.Builder, id: String? = nil) -> Future<WalletRecordDto?, Error> {
        return Future { promise in
            var record: WalletRecordDto? = nil
            self.search([
                        "name", tag.get("name"),
                        "version", tag.get("version"),
                        "state", tag.get("state")
                    ]).map { walletResponse in
                        if (walletResponse.isNotEmpty()) {
                            self.logger.error(message: "credential has already been in wallet \(value) \(tag.build())")
                            promise(.failure(CustomError(errorMessage: ErrorMessage.INTERNAL_ERROR)))
                        } else {
                            record = WalletRecordDto(
                                    type: WalletRecordTypeEnum.CREDENTIAL,
                                    uuid: id ?? UUID().uuidString,
                                    value: value,
                                    tag: tag.build()
                            )
                            self.logger.info(message: "saving credential \(value) with id \(record!.uuid)")
                        }
                        return record
                    }
                    .flatMap({ (connectionRecord: WalletRecordDto?) -> Future<Int, Error> in
                        self.walletRecordPort.add(record: connectionRecord!)
                    })
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): promise(.failure(error))
                        }
                    }, receiveValue: { _ in
                        promise(.success(record))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func updateTags(uid: String, newTags: WalletTagsBuilder.Builder) -> Future<Int, Error> {
        return Future { promise in
        }
    }
}