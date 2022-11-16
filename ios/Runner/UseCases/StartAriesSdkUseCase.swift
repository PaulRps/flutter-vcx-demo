//
//  StartAriesSdkUseCase.swift
//  Runner
//
//  Created by Paulo Silva on 30/08/22.
//

import Foundation
import Combine

class StartAriesSdkUseCase {
    private final let logger = CustomLogger(context: StartAriesSdkUseCase.self)
    private final var cancellables: Set<AnyCancellable>
    private final let walletRepository: AriesWalletRepository
    private final let agencyRepository: AriesAgencyRepository
    private final let poolRepository: AriesPoolRepository
    private final let ariesSdkRepository: AriesSdkRepository

    init(
            ariesSdkRepository: AriesSdkRepository = AriesSdkRepository(),
            walletRepository: AriesWalletRepository = AriesWalletRepository(),
            agencyRepository: AriesAgencyRepository = AriesAgencyRepository(),
            poolRepository: AriesPoolRepository = AriesPoolRepository()
    ) {
        self.ariesSdkRepository = ariesSdkRepository
        self.walletRepository = walletRepository
        self.agencyRepository = agencyRepository
        self.poolRepository = poolRepository
        cancellables = Set()
    }

    func start(config: StartAriesSdkConfigDto) -> AnyPublisher<NativeToFlutterResponseDto, Error> {
        Deferred {
            Future { promise in

                if (!self.isAriesSdkConfigOk(config: config)) {
                    self.logger.error(message: "error on starting aries sdk with missing configuration")
                    promise(.failure(CustomError(errorMessage: ErrorMessage.ARIES_SDK_INIT_ERROR)))
                    return
                }

                self.logger.info(message: "starting aries sdk with config \(config)")

                self.ariesSdkRepository.setSdkLogLevel(logLevel: config.logLevel)

                let provision = self.agencyRepository.getProvisionConfig()

                var initialization: AnyPublisher<String, Error>
                if (provision.isEmpty) {
                    initialization = self.firstInitAgentVcx(config: config)
                } else {
                    initialization = self.initAgentVcx(config: config, provisionConfig: provision)
                }

                initialization.sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on starting aries sdk: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { provisionConfig in
                            self.logger.info(message: "finished start aries sdk with success=\(!provisionConfig.isEmpty)")
                            let agentDid = self.readAgentDid(provisionConfig)
                            promise(.success(StartAriesSdkResponseDto(success: !provisionConfig.isEmpty, agentDid: agentDid)))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func firstInitAgentVcx(config: StartAriesSdkConfigDto) -> AnyPublisher<String, Error> {
        Deferred {
            Future { promise in
                self.logger.info(message: "starting first initialization of vcx agent")

                var provisionAgency = ""
                self.poolRepository.initPool(config: config.initThreadPoolConfig!).map { _ in

                        }
                        .flatMap({
                            self.walletRepository.createWallet(config: config.localWalletConfig!)
                        })
                        .flatMap({ _ in
                            self.walletRepository.openWallet(config: config.localWalletConfig!)
                        })
                        .flatMap({ _ in
                            self.agencyRepository.provisionCloudAgency(config: config.provision!)
                        })
                        .map { provision in
                            provisionAgency = provision
                            self.agencyRepository.saveProvisionConfig(config: provisionAgency)
                        }
                        .flatMap({ _ in
                            self.agencyRepository.createAgencyForMainWallet(provision: provisionAgency)
                        })
                        .flatMap({ _ in
                            self.poolRepository.openMainPool(config: config.openMainPoolConfig!)
                        })
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on first initialization of agency: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in
                            self.logger.info(message: "finished first initialization of agent successfully")
                            promise(.success(provisionAgency))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func initAgentVcx(config: StartAriesSdkConfigDto, provisionConfig: String) -> AnyPublisher<String, Error> {
        Deferred {
            Future { promise in
                self.logger.info(message: "initializing agent")

                self.poolRepository.initPool(config: config.initThreadPoolConfig!)
                        .map { _ in
                        }
                        .flatMap({ _ in
                            self.walletRepository.openWallet(config: config.localWalletConfig!)
                        })
                        .flatMap({ _ in
                            self.agencyRepository.createAgencyForMainWallet(provision: provisionConfig)
                        })
                        .flatMap({ _ in
                            self.poolRepository.openMainPool(config: config.openMainPoolConfig!)
                        })
                        .sink(receiveCompletion: { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.logger.error(message: "error on initialization of agency: \(error.localizedDescription)")
                                promise(.failure(error))
                            }
                        }, receiveValue: { _ in
                            self.logger.info(message: "initialized vcx agent successfully")
                            promise(.success(provisionConfig))
                        })
                        .store(in: &self.cancellables)
            }
        }
                .eraseToAnyPublisher()
    }

    private func isAriesSdkConfigOk(config: StartAriesSdkConfigDto) -> Bool {
        config.provision != nil &&
                config.initThreadPoolConfig != nil &&
                config.localWalletConfig != nil &&
                config.openMainPoolConfig != nil
    }

    private func readAgentDid(_ agencyConfig: String) -> String? {
        let jsonObject = JsonUtil.toDictionary(agencyConfig)
        return jsonObject?["remote_to_sdk_did"] as? String
    }
}
