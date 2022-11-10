//
// Created by Paulo Silva on 06/10/22.
//

import Foundation
import Combine

class AriesConnectionRecordRepository {
    private final let logger = CustomLogger(context: AriesConnectionRecordRepository.self)

    private final let walletRecordPort: WalletRecordPort
    private final let walletSearchPort: WalletSearchPort
    private final var cancellables: Set<AnyCancellable>

    init(
            walletRecordPort: WalletRecordPort = WalletRecordAdapter(),
            walletSearchPort: WalletSearchPort = WalletSearchAdapter()
    ) {
        self.walletRecordPort = walletRecordPort
        self.walletSearchPort = walletSearchPort
        cancellables = Set()
    }

    func search(keyValQuery: Array<String>) -> Future<SearchWalletResponseDto, Error> {
        let queryJson = WalletTagsBuilder.Builder().encrypted(keyValQuery).build()
        logger.info(message: "searching aries connection record with query: \(queryJson)")

        return walletSearchPort.search(
                query: WalletQueryDto(
                        type: WalletRecordTypeEnum.CONNECTION.value,
                        json: queryJson
                ),
                count: 100
        )
    }

    func save(value: String, tag: ConnectionTagsDto) -> Future<WalletRecordDto?, Error> {
        Future { promise in
            self.logger.info(message: "saving connection record in wallet")

            let query = ["their_label", tag.theirLabel!, "serviceEndpoint", tag.serviceEndpoint!]

            self.search(keyValQuery: query)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): promise(.failure(error))
                        }
                    }, receiveValue: { walletResponse in
                        if walletResponse.isNotEmpty() &&
                                   AriesConnectionUtil.isConnectionFinished(connection: walletResponse.records?[0]) {

                            self.logger.error(message: "connection record already exists in wallet")

                            promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                            return
                        }

                        let record = WalletRecordDto(
                                type: .CONNECTION,
                                uuid: UUID().uuidString,
                                value: value,
                                tag: tag.toJson()
                        )

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

    func update(record: WalletRecordDto, keyValTag: Array<String>?) -> Future<Int, Error> {
        Future { promise in
            self.logger.info(message: "updating connection record \(record.toJson()) with tag \(String(describing: keyValTag))")

            self.walletRecordPort.update(record: record)
                    .map { _ in

                    }
                    .flatMap({
                        self.updateTags(recordId: record.uuid, baseJsonTag: record.tag!, keyValTag: keyValTag)
                    })
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on updating connection record: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    }, receiveValue: { _ in
                        self.logger.info(message: "updated connection record successfully")
                        promise(.success(0))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func update(
            queryState: ConnectionStateEnum,
            record: WalletRecordDto,
            keyValTag: Array<String>?
    ) -> Future<Int, Error> {
        Future { promise in
            let query = ["state", queryState.value, "request_id", record.uuid]

            self.search(keyValQuery: query)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error): promise(.failure(error))
                        }
                    }, receiveValue: { searchResponse in
                        if searchResponse.isEmpty() {
                            promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                            return
                        }

                        let connectionRecord = searchResponse.records![0]
                        self.update(record: WalletRecordDto.from(connectionRecord), keyValTag: keyValTag).sink(receiveCompletion: { completion in
                                    switch completion {
                                    case .finished: break
                                    case .failure(let error):
                                        self.logger.error(message: "error on updating connection record: \(error.localizedDescription)")
                                        promise(.failure(error))
                                    }
                                }, receiveValue: { _ in
                                    self.logger.info(message: "updated connection record successfully")
                                    promise(.success(0))
                                })
                                .store(in: &self.cancellables)
                    })
                    .store(in: &self.cancellables)


        }
    }

    func updateTags(
            recordId: String,
            baseJsonTag: String,
            keyValTag: Array<String>?
    ) -> Future<Int, Error> {
        Future { promise in
            if keyValTag?.isEmpty == true || keyValTag!.count % 2 != 0 {
                promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                return
            }

            let newTags = WalletTagsBuilder.Builder(baseJsonTag).encrypted(keyValTag!).build()

            self.logger.info(message: "updating connection record tags with \(newTags)")

            self.walletRecordPort.updateTags(
                            record: WalletRecordDto(
                                    type: .CONNECTION,
                                    uuid: recordId,
                                    tag: newTags
                            )
                    ).sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on updating connection record: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    }, receiveValue: { _ in
                        self.logger.info(message: "updated connection record successfully")
                        promise(.success(0))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func findConnectionByDid(did: String) -> Future<SearchRecordDto?, Error> {
        Future { promise in
            self.logger.info(message: "finding connection record by did=\(did)")
            let query = ["my_did", did]
            self.search(keyValQuery: query)
                    .map { searchResponse in
                        searchResponse.records?[0]
                    }
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on finding connection record by did: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    }, receiveValue: { connectionRecord in
                        self.logger.info(message: "found connection record by did successfully")
                        promise(.success(connectionRecord))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func delete(recordId: String) -> Future<Int, Error> {
        logger.info(message: "deleting wallet record by id: \(recordId)")
        return walletRecordPort.deleteRecord(
                type: .CONNECTION,
                uuid: recordId
        )
    }

    func saveSerializedConnection(
            _ serializedConnection: String,
            _ tags: ConnectionTagsDto
    ) -> Future<WalletRecordDto?, Error> {
        let myTheirDid = getMyTheirDidFrom(serializedConnection)
        let pairwiseDid = myTheirDid["my_did"]
        tags.myDid = pairwiseDid
        tags.theirDid = myTheirDid["their_did"]
        tags.createdAt = DateUtil.currentDateTime()
        tags.state = ConnectionStateEnum.FINISHED.value
        return save(value: serializedConnection, tag: tags)
    }

    private func getMyTheirDidFrom(_ serializedConnection: String) -> [String: String] {
        let connectionDict = JsonUtil.toDictionary(serializedConnection)
        let conData = connectionDict!["data"] as! [String: AnyObject]
        let myDid = conData["pw_did"] as! String

        let conState = connectionDict!["state"] as! [String: AnyObject]
        let conInvitee = conState["Invitee"] as! [String: AnyObject]
        let conInviteeCompleted = conInvitee["Completed"] as! [String: AnyObject]
        let didDoc = conInviteeCompleted["did_doc"] as! [String: AnyObject]
        let id = didDoc["id"] as! String
        let theirDid = id.split(separator: ":").map {
            String($0)
        }

        return ["my_did": myDid, "their_did": theirDid[2]]
    }
}
