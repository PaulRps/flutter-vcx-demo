//
//  ShutdownAriesSdkUsecase.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation
import Combine

class ShutdownOrResetAriesSdkUsecase {
    private final let logger = CustomLogger(context: ShutdownOrResetAriesSdkUsecase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let walletRepository: AriesWalletRepository
    private final let agencyRepository: AriesAgencyRepository
    private final let ariesSdkRepository: AriesSdkRepository

    init(
            ariesSdkRepository: AriesSdkRepository = AriesSdkRepository(),
            walletRepository: AriesWalletRepository = AriesWalletRepository(),
            agencyRepository: AriesAgencyRepository = AriesAgencyRepository()
    ) {
        self.ariesSdkRepository = ariesSdkRepository
        self.walletRepository = walletRepository
        self.agencyRepository = agencyRepository
        cancellables = Set()
    }

    func shutdown(isToDeleteWallet: Bool?) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in
                var wasWalletClosed = false

                self.logger.info(message: "starting wallet shutdown isToDeleteWallet=\(isToDeleteWallet)")

                self.walletRepository.closeWallet().map { wasClosed in
                            wasWalletClosed = wasClosed
                        }
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on closing wallet: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in

                            let wasWalletShutdown = self.ariesSdkRepository.shutdownAriesSdk(isToDeleteWallet: isToDeleteWallet)

                            var wasLocalProvisionDeleted = true
                            if isToDeleteWallet == true {
                                wasLocalProvisionDeleted = self.agencyRepository.deleteProvisionConfig()
                            }

                            let success = wasWalletClosed && wasWalletShutdown && wasLocalProvisionDeleted

                            self.logger.info(message: "finished wallet shutdown with success=\(success)")

                            promise(.success(NativeToFlutterResponseDto(success: success)))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }
}
