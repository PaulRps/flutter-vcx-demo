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

    private final let acceptCredentialOffer: AcceptCredentialOfferUseCase
    private final let getIssuedCredentials: GetIssuedCredentialsUseCase

    init(
            input: FlutterRequestAriesCredentialChannelDto,
            acceptCredentialOffer: AcceptCredentialOfferUseCase = AcceptCredentialOfferUseCase(),
            getIssuedCredentials: GetIssuedCredentialsUseCase = GetIssuedCredentialsUseCase()
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