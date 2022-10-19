//
// Created by Paulo Silva on 06/10/22.
//

import Foundation
import Combine

class AriesCredentialRecordRepository {
    private final let logger = CustomLogger(context: AriesCredentialRecordRepository.self)
    private var walletRecordPort: WalletRecordPort
    private var walletSearchPort: WalletSearchPort
    private var cancellables: Set<AnyCancellable>

    init(
            walletRecordPort: WalletRecordPort = WalletRecordAdapter(),
            walletSearchPort: WalletSearchPort = WalletSearchAdapter()
    ) {
        self.walletRecordPort = walletRecordPort
        self.walletSearchPort = walletSearchPort
        cancellables = Set()
    }

    func search(_ keyValQuery: Array<String>) -> Future<SearchWalletResponseDto, Error> {
        let queryJson = WalletTagsBuilder.Builder().encrypted(keyValQuery).build()

        logger.info(message: "searching aries credential record with query: \(queryJson)")

        return walletSearchPort.search(
                query: WalletQueryDto(
                        type: WalletRecordTypeEnum.CONNECTION.value,
                        json: queryJson
                ),
                count: 100
        )
    }

    func save(value: String, tag: WalletTagsBuilder.Builder, id: String? = nil) -> Future<WalletRecordDto?, Error> {
        Future { promise in
            self.search([
                        "name", tag.get("name"),
                        "version", tag.get("version"),
                        "state", tag.get("state")
                    ])
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): promise(.failure(error))
                        }
                    }, receiveValue: { walletResponse in
                        if (walletResponse.isNotEmpty()) {
                            self.logger.info(message: "credential has already been in wallet \(value) \(tag.build())")
                            promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                            return
                        }

                        let record = WalletRecordDto(
                                type: .CONNECTION,
                                uuid: id ?? UUID().uuidString,
                                value: value,
                                tag: tag.build()
                        )

                        self.logger.info(message: "saving credential \(value) with id \(record.uuid)")

                        self.walletRecordPort.add(record: record).sink(receiveCompletion: { completion in
                                    switch completion {
                                    case .finished: break
                                    case .failure(let error): promise(.failure(error))
                                    }
                                }, receiveValue: { _ in
                                    promise(.success(record))
                                })
                                .store(in: &self.cancellables)
                    })
                    .store(in: &self.cancellables)
        }
    }
}
