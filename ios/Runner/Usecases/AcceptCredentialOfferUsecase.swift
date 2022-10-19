//
// Created by Paulo Silva on 05/09/22.
//

import Foundation
import Combine

class AcceptCredentialOfferUsecase {
    private final let logger = CustomLogger(context: AcceptCredentialOfferUsecase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let credentialRepository: AriesCredentialRepository
    private final let connectionRepository: AriesConnectionRepository
    private final let agencyRepository: AriesAgencyRepository

    init(
            credentialRepository: AriesCredentialRepository = AriesCredentialRepository(),
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository(),
            agencyRepository: AriesAgencyRepository = AriesAgencyRepository()
    ) {
        self.credentialRepository = credentialRepository
        self.connectionRepository = connectionRepository
        self.agencyRepository = agencyRepository
        cancellables = Set()
    }

    func acceptOffer(
            pairwiseDid: String?,
            sourceId: String?
    ) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                if !self.isParamsOk(pairwiseDid: pairwiseDid, sourceId: sourceId) {
                    promise(.failure(CustomError(errorMessage: .INTERNAL_ERROR)))
                    return
                }

                var connectionHandle: NSNumber = 0
                var credentialHandle: NSNumber = 0
                var serializedCredential: String = ""
                self.connectionRepository.getConnectionHandleByPwDid(pairwiseDid: pairwiseDid!)
                        .map { connHandle in
                            connectionHandle = connHandle
                        }
                        .flatMap({ _ in
                            self.credentialRepository.getOffer(fromConnection: connectionHandle)
                        })
                        .flatMap({ offer in
                            self.credentialRepository.createCredential(
                                    withOffer: offer,
                                    sourceId: sourceId!
                            )
                        })
                        .map { credHandle in
                            credentialHandle = credHandle
                        }
                        .flatMap({
                            self.agencyRepository.updateMessageStatus(
                                    newStaus: AgencyMessageStatusEnum.REVIEWED,
                                    pairwiseDid: pairwiseDid!,
                                    msgUids: []
                            )
                        })
                        .flatMap({ _ in
                            self.credentialRepository.sendRequest(
                                    credentialHandle: credentialHandle,
                                    connectionHandle: connectionHandle,
                                    paymentHandle: 0 as NSNumber
                            )
                        })
                        .flatMap({ _ in
                            AriesStateUpdateAttempter().tryUpdateState(
                                    method: {
                                        self.credentialRepository.updateCredentialState(
                                                credentialHandle: credentialHandle,
                                                connectionHandle: connectionHandle
                                        )
                                    },
                                    logger: self.logger
                            )
                        })
                        .flatMap({ _ in
                            self.credentialRepository.getSerializedCredential(credentialHandle: credentialHandle)
                        })
                        .map { credentialJson in
                            serializedCredential = credentialJson
                        }
                        .flatMap({
                            self.credentialRepository.saveIssuedCredential(
                                    serializedCredential: serializedCredential,
                                    pairwiseDid: pairwiseDid!
                            )
                        })
                        .sink(receiveCompletion: { completion in
                            self.releaseHandles(
                                    credentialHandle: credentialHandle,
                                    connectionHandle: connectionHandle
                            )
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on accepting credential offer: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { record in
                            let response: AcceptCredentialOfferResponseDto = self.buildResponse(from: record)

                            self.logger.info(message: "finished accept credential offer success=\(response.success)")

                            promise(.success(response))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }


    private func buildResponse(from: WalletRecordDto?) -> AcceptCredentialOfferResponseDto {
        let success = from?.uuid.isEmpty == false
        let tags = JsonUtil.toType(from?.tag ?? "", [String: String].self)
        let credName = tags?["name"] ?? ""
        let credVersion = tags?["version"] ?? ""
        let cred = "\(credName):\(credVersion)"
        return AcceptCredentialOfferResponseDto(
                credentialName: cred,
                success: success
        )
    }

    private func isParamsOk(pairwiseDid: String?, sourceId: String?) -> Bool {
        pairwiseDid != nil && pairwiseDid?.isEmpty == false &&
                sourceId != nil && sourceId?.isEmpty == false
    }

    private func releaseHandles(credentialHandle: NSNumber?, connectionHandle: NSNumber?) {
        _ = connectionRepository.releaseHandle(handle: connectionHandle)
        _ = credentialRepository.releaseHandle(handle: credentialHandle)
    }
}
