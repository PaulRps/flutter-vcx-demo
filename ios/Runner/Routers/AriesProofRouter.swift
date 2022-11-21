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

    private final let presentProofUsecase: ProverPresentProofUseCase
    private final let rejectProofUsecase: ProverRejectPresentProofRequestUseCase
    private final let sendProofRequest: VerifierRequestPresentProofUseCase

    init(
            input: FlutterRequestAriesProofChannelDto,
            presentProofUsecase: ProverPresentProofUseCase = ProverPresentProofUseCase(),
            rejectProofUsecase: ProverRejectPresentProofRequestUseCase = ProverRejectPresentProofRequestUseCase(),
            sendProofRequest: VerifierRequestPresentProofUseCase = VerifierRequestPresentProofUseCase()
    ) {
        self.input = input
        self.presentProofUsecase = presentProofUsecase
        self.rejectProofUsecase = rejectProofUsecase
        self.sendProofRequest = sendProofRequest
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
        routes["sendRequest"] = sendProofRequest.sendRequest(pairwiseDid: input.pairwiseDid)
    }
}
