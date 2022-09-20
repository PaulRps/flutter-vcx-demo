//
//  GetMessageFromAriesAgencyUsecase.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation
import Combine

class GetMessageByConnectionFromAriesAgencyUsecase {
    private final var cancellables: Set<AnyCancellable>
    private final let logger = CustomLogger(context: GetMessageByConnectionFromAriesAgencyUsecase.self)
    private final let agencyRepository: AriesAgencyRepository
    private final let connectionRepository: AriesConnectionRepository

    init(
            agencyRepository: AriesAgencyRepository = AriesAgencyRepository(),
            connectionRepository: AriesConnectionRepository = AriesConnectionRepository()
    ) {
        self.agencyRepository = agencyRepository
        self.connectionRepository = connectionRepository
        cancellables = Set()
    }

    func getMessage(
            messageStatus: AgencyMessageStatusEnum,
            messageUid: String?,
            pairwiseDid: String?
    ) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                self.logger.info(
                        message: "searching aries agency message by ID=\(messageUid), PWDid=\(pairwiseDid) and Status=\(messageStatus.value)"
                )
                var connectionHandle: NSNumber?
                var msgJson = ""
                self.connectionRepository.getConnectionHandleByPwDid(
                                pairwiseDid: pairwiseDid ?? ""
                        ).map({ handle in
                            connectionHandle = handle
                        })
                        .flatMap({
                            self.agencyRepository.getMessage(
                                    connectionHandle: connectionHandle,
                                    messageStatus: messageStatus,
                                    messageUid: messageUid
                            )
                        })
                        .map { msg in
                            msgJson = msg
                        }
                        .flatMap({ msg in
                            self.connectionRepository.releaseHandle(connectionHandle: connectionHandle)
                        })
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on searching agency message: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in
                            self.logger.info(message: "finished search agency message success=\(!msgJson.isEmpty)")
                            promise(.success(self.buildResponse(msgJson: msgJson)))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func buildResponse(msgJson: String) -> GetAriesAgencyMessageDto {
        let json = JsonUtil.toType(msgJson, Array<[String: Any]>.self)
        let firstMsg = json?[0]
        let msg = JsonUtil.toJson(firstMsg?["msgs"] as? Any)

        return GetAriesAgencyMessageDto(
                msg: msg,
                pairwiseDid: firstMsg?["pairwiseDID"] as? String ?? "",
                success: msg.isEmpty == false
        )
    }
}
