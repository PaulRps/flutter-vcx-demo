//
// Created by Paulo Silva on 16/09/22.
//

import Foundation
import Combine

class GetIssuedCredentialsUseCase {

    private final let logger = CustomLogger(context: GetIssuedCredentialsUseCase.self)
    private final let credentialRepository: AriesCredentialRepository
    private final var cancellables: Set<AnyCancellable>

    init(credentialRepository: AriesCredentialRepository = AriesCredentialRepository()) {
        self.credentialRepository = credentialRepository
        cancellables = Set()
    }

    func getIssuedCredentials() -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                self.credentialRepository.getSerializedCredentials()
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on getting issued credential: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { credentials in
                            let response = GetCredentialsResponseDto.create(from: credentials)
                            promise(.success(response))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }
}
