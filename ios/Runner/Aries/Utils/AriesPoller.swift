//
//  AriesCallingAttempter.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

class AriesPoller {
    private final let tryLimit: Int
    private final let timer: Timer.TimerPublisher
    private final var cancellables: Set<AnyCancellable>
    private final var cancellableTimer: AnyCancellable?

    init(
            tryLimit: Int = 5,
            interval: TimeInterval = 2
    ) {
        self.tryLimit = tryLimit
        timer = Timer.publish(every: interval, on: .current, in: .common)
        cancellables = Set()
    }

    func tryUpdateState(
            method: @escaping () -> Future<AriesFinishedState, Error>,
            logger: CustomLogger
    ) -> Future<Bool, Error> {
        Future { promise in
            var tryingCount = 0
            self.cancellableTimer = self.timer.autoconnect().sink { _ in
                method().sink { completion in
                            switch completion {
                            case .finished: break
                            case .failure(let error):
                                self.cancellableTimer!.cancel()
                                promise(.failure(error))
                            }
                        } receiveValue: { state in
                            tryingCount += 1
                            logger.info(message: "calling update state [try=\(tryingCount)]")
                            if state.isFinished() {
                                logger.info(message: "finished update call successfully")
                                self.cancellableTimer!.cancel()
                                promise(.success(true))
                            } else if tryingCount >= self.tryLimit {
                                logger.error(message: "try limit exceeded")
                                self.cancellableTimer!.cancel()
                                promise(.failure(CustomError(errorMessage: ErrorMessage.INTERNAL_ERROR)))
                            }
                        }
                        .store(in: &self.cancellables)
            }
        }
    }

}
