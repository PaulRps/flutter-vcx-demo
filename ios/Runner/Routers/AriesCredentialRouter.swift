//
// Created by Paulo Silva on 05/09/22.
//

import Foundation
import Combine

class AriesCredentialRouter: Router {
    typealias I = FlutterRequestAriesCredentialChannelDto

    var input: FlutterRequestAriesCredentialChannelDto

    var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] = [:]

    var logger = CustomLogger(context: AriesCredentialRouter.self)

    private final let acceptCredentialOffer: AcceptCredentialOfferUsecase
    private final let getIssuedCredentials: GetIssuedCredentialsUsecase

    init(
            input: FlutterRequestAriesCredentialChannelDto,
            acceptCredentialOffer: AcceptCredentialOfferUsecase = AcceptCredentialOfferUsecase(),
            getIssuedCredentials: GetIssuedCredentialsUsecase = GetIssuedCredentialsUsecase()
    ) {
        self.input = input
        self.acceptCredentialOffer = acceptCredentialOffer
        self.getIssuedCredentials = getIssuedCredentials
        setRoutes()
    }

    private func setRoutes() {
        routes["acceptOffer"] = acceptCredentialOffer.acceptOffer(
                pairwiseDid: input.pairwiseDid,
                sourceId: input.sourceId
        )

        routes["getCredentials"] = getIssuedCredentials.getIssuedCredentials()
    }
}