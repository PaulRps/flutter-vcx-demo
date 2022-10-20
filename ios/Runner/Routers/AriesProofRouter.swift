//
// Created by Paulo Silva on 09/09/22.
//

import Foundation
import Combine

class AriesProofRouter: Router {
    final let input: FlutterRequestAriesProofChannelDto

    final var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] = [:]

    final let logger = CustomLogger(context: AriesProofRouter.self)

    typealias I = FlutterRequestAriesProofChannelDto

    private final let presentProofUsecase: PresentProofRequestUsecase
    private final let rejectProofUsecase: RejectProofRequestUsecase

    init(
            input: FlutterRequestAriesProofChannelDto,
            presentProofUsecase: PresentProofRequestUsecase = PresentProofRequestUsecase(),
            rejectProofUsecase: RejectProofRequestUsecase = RejectProofRequestUsecase()
    ) {
        self.input = input
        self.presentProofUsecase = presentProofUsecase
        self.rejectProofUsecase = rejectProofUsecase
        setRoutes()
    }

    private func setRoutes() {
        routes["presentProof"] = presentProofUsecase.presentProof(
                pairwiseDid: input.pairwiseDid,
                sourceId: input.sourceId
        )
        routes["rejectProof"] = rejectProofUsecase.reject(
                pairwiseDid: input.pairwiseDid,
                sourceId: input.sourceId
        )
    }
}
