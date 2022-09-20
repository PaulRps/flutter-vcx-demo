//
//  ConnectionRecordAdapter.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

class ConnectionRecordAdpater : ConnectionRecordPort  {
    private final let logger = CustomLogger(context: ConnectionRecordAdpater.self)
    
    private final let walletRecordPort:  WalletRecordAdapter
    private final let walletSearchPort:  WalletSearchAdapter
    private final var cancellables: Set<AnyCancellable>
    
    init(
        walletRecordPort:  WalletRecordAdapter=WalletRecordAdapter(),
        walletSearchPort:  WalletSearchAdapter=WalletSearchAdapter()
    ){
        self.walletRecordPort =  walletRecordPort
        self.walletSearchPort =  walletSearchPort
        cancellables = Set()
    }
    
    func search(keyValQuery: Array<String>) -> Future<SearchWalletResponseDto,Error>{
        let queryJson = WalletTagsBuilder.Builder().encrypted(keyValQuery).build()
        
        logger.info(message: "searching aries connnection record with query: \(queryJson)")
        
        return walletSearchPort.search(
            query: WalletQueryDto(
                type : WalletRecordTypeEnum.CONNECTION.value,
                json : queryJson
            ),
            count: 100
        )
    }
    
    func save(value: String, tag: ConnectionTagsDto)->Future<WalletRecordDto?,Error> {
        Future { promise in
            self.logger.info(message: "saving connection record in wallet")

            var record: WalletRecordDto? = nil
            let query = ["their_label", tag.theirLabel!, "serviceEndpoint", tag.serviceEndpoint!]

            self.search(keyValQuery: query)
                    .map { walletResponse in
                        if walletResponse.isNotEmpty() &&
                                   AriesConnectionUtil.isConnectionFinished(connection: walletResponse.records?[0]) {

                            self.logger.error(message: "connection record already exists in wallet")

                            promise(.failure(CustomError(errorMessage: ErrorMessage.INTERNAL_ERROR)))
                            return
                        }

                        record = WalletRecordDto(
                                type: WalletRecordTypeEnum.CONNECTION,
                                uuid: UUID().uuidString,
                                value: value,
                                tag: tag.toJson()
                        )

                    }
                    .flatMap({ _ in
                        self.walletRecordPort.add(record: record!)
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
    
    func update(record: WalletRecordDto, keyValTag: Array<String>?) -> Future<Int,Error>  {
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
                        self.logger.info(message: "updated connection record sucessfully")
                        promise(.success(0))
                    })
                    .store(in: &self.cancellables)
        }
    }
    
    func update(
        queryState: ConnectionStateEnum,
        record: WalletRecordDto,
        keyValTag: Array<String>?
    )-> Future<Int,Error> {
        Future { promise in
            var connectionRecord: SearchRecordDto? = nil
            let query = ["state", queryState.value, "request_id", record.uuid]

            self.search(keyValQuery: query)
                    .map { searchResponse in

                        if searchResponse.isEmpty() {
                            promise(.failure(CustomError(errorMessage: ErrorMessage.INTERNAL_ERROR)))
                            return
                        }

                        connectionRecord = searchResponse.records![0]
                    }
                    .flatMap({
                        self.update(record: WalletRecordDto.from(connectionRecord!), keyValTag: keyValTag)
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
    
    func updateTags(
        recordId: String,
        baseJsonTag: String,
        keyValTag: Array<String>?
    ) -> Future<Int,Error> {
        Future { promise in
            if keyValTag?.isEmpty == true || keyValTag!.count % 2 != 0 {
                promise(.failure(CustomError(errorMessage: ErrorMessage.INTERNAL_ERROR)))
                return
            }

            let newTags = WalletTagsBuilder.Builder(baseJsonTag).encrypted(keyValTag!).build()

            self.logger.info(message: "updating connection record tags with \(newTags)")

            self.walletRecordPort.updateTags(
                            record: WalletRecordDto(
                                    type: WalletRecordTypeEnum.CONNECTION,
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
                        searchResponse.records![0]
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
    
    func delete(recordId: String)-> Future<Int,Error>{
        logger.info(message: "deleting wallet record by id: \(recordId)")
        return walletRecordPort.deleteRecord(
            type: WalletRecordTypeEnum.CONNECTION,
            uuid: recordId
        )
    }
}
