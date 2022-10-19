//
// Created by Paulo Silva on 05/09/22.
//

import Foundation
import Combine

class AriesCredentialRepository {
    private final let logger = CustomLogger(context: AriesConnectionRepository.self)
    private final var cancellables: Set<AnyCancellable>

    private final let credentialPort: CredentialPort
    private final let credentialRecordRepository: AriesCredentialRecordRepository

    init(
            credentialPort: CredentialPort = AriesCredentialAdapter(),
            credentialRecordRepository: AriesCredentialRecordRepository = AriesCredentialRecordRepository()
    ) {
        self.credentialPort = credentialPort
        self.credentialRecordRepository = credentialRecordRepository
        cancellables = Set()
    }

    func getOffer(fromConnection: NSNumber) -> Future<String, Error> {
        Future { promise in
            self.credentialPort.getOffers(connectionHandle: fromConnection)
                    .map { offers in
                        let credOffers = JsonUtil.toType(offers, Array<Any>.self)
                        return credOffers?.isEmpty == false ? JsonUtil.toJson(credOffers?[0]) : ""
                    }
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on getting credential offer: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    }, receiveValue: { credentialOffer in
                        promise(.success(credentialOffer))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func createCredential(withOffer: String, sourceId: String) -> Future<NSNumber, Error> {
        credentialPort.createCredential(withOffer: withOffer, sourceId: sourceId)
    }

    func sendRequest(
            credentialHandle: NSNumber,
            connectionHandle: NSNumber,
            paymentHandle: NSNumber
    ) -> Future<NSNumber, Error> {
        credentialPort.sendRequest(
                credentialHandle: credentialHandle,
                connectionHandle: connectionHandle,
                paymentHandle: paymentHandle
        )
    }

    func getSerializedCredential(credentialHandle: NSNumber) -> Future<String, Error> {
        credentialPort.getSerializedCredential(credentialHandle: credentialHandle)
    }

    func releaseHandle(credentialHandle: NSNumber?) -> Future<NSNumber, Error> {
        Future { promise in
            promise(.success(self.credentialPort.releaseHandle(handle: credentialHandle)))
        }
    }

    func releaseHandle(handle: NSNumber?) -> NSNumber {
        credentialPort.releaseHandle(handle: handle)
    }

    func updateCredentialState(
            credentialHandle: NSNumber,
            connectionHandle: NSNumber
    ) -> Future<AriesFinishedState, Error> {
        credentialPort.updateState(
                credentialHandle: credentialHandle,
                connectionHandle: connectionHandle
        )
    }

    func saveIssuedCredential(
            serializedCredential: String,
            pairwiseDid: String
    ) -> Future<WalletRecordDto?, Error> {
        Future { promise in
            self.logger.info(message: "saving issued credential \(serializedCredential)")

            let data = JsonUtil.toDictionary(serializedCredential)?["data"] as? [String: AnyObject]
            let holder = data?["holder_sm"] as? [String: AnyObject]
            let credentialId = (holder?["thread_id"] as? String) ?? UUID().uuidString
            let credNameVersion = AriesCredentialUtil.getCredentialNameVersion(from: serializedCredential)

            let tag = WalletTagsBuilder.Builder()
                    .encrypted("id", credentialId)
                    .encrypted("createdAt", DateUtil.currentDateTime())
                    .encrypted("name", credNameVersion["name"]!)
                    .encrypted("version", credNameVersion["version"]!)
                    .encrypted("issuer", pairwiseDid)
                    //                .encrypted("credentialPreview", credentialPreview.toJson())
                    .encrypted("state", CredentialStateEnum.FINISHED.value)

            self.credentialRecordRepository.save(
                            value: serializedCredential,
                            tag: tag,
                            id: credentialId
                    )
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on saving issued credential: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    }, receiveValue: { record in
                        self.logger.info(message: "finished save issued credential in wallet")
                        self.logger.debug(message: "credential record: \(record?.toJson() ?? "")")
                        promise(.success(record))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func getSerializedCredentials() -> Future<[SearchRecordDto], Error> {
        Future { promise in
            self.logger.info(message: "getting all issued credentials in wallet")
            self.credentialRecordRepository.search(["state", CredentialStateEnum.FINISHED.value])
                    .map { searchWalletResponseDto -> [SearchRecordDto] in
                        searchWalletResponseDto.records ?? []
                    }
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished: break
                        case .failure(let error):
                            self.logger.error(message: "error on getting issued credential: \(error.localizedDescription)")
                            promise(.failure(error))
                        }
                    }, receiveValue: { dtos in
                        self.logger.info(message: "got \(dtos.count) issued credentials in wallet")
                        promise(.success(dtos))
                    })
                    .store(in: &self.cancellables)
        }
    }

    func getCredentialNameAndVersion(from: String) -> [String: String] {
        AriesCredentialUtil.getCredentialNameVersion(from: from)
    }
}