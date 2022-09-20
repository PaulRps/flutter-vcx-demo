//
// Created by Paulo Silva on 09/09/22.
//

import Foundation
import Combine

class AriesProofMethodResolver: MethodResolver {
    final let input: FlutterRequestAriesProofChannelDto

    final var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] = [:]

    final let logger = CustomLogger(context: AriesProofMethodResolver.self)

    typealias I = FlutterRequestAriesProofChannelDto

    private final let presentProofUsecase: PresentProofRequestUsecase

    init(
            input: FlutterRequestAriesProofChannelDto,
            presentProofUsecase: PresentProofRequestUsecase = PresentProofRequestUsecase()
    ) {
        self.input = input
        self.presentProofUsecase = presentProofUsecase
        setRoutes()
    }

    private func setRoutes() {
        routes["presentProof"] = presentProofUsecase.presentProof(
                pairwiseDid: input.pairwiseDid,
                sourceId: input.sourceId
        )
    }
}
