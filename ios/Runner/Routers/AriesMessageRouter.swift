//
//  AriesMessageMethodResolver.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation
import Combine

class AriesMessageRouter: Router {
    let logger = CustomLogger(context: AriesMessageRouter.self)
    typealias I = FlutterRequestAriesMessageChannelDto
    let input: FlutterRequestAriesMessageChannelDto
    var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] = [:]

    private final let getMessageUsecase: GetMessageByConnectionFromAriesAgencyUseCase

    init(
            input: FlutterRequestAriesMessageChannelDto,
            getMessageUsecase: GetMessageByConnectionFromAriesAgencyUseCase = GetMessageByConnectionFromAriesAgencyUseCase()
    ) {
        self.input = input
        self.getMessageUsecase = getMessageUsecase
        setRoutes()
    }

    private func setRoutes() {
        routes["getOneByPwDid"] = getMessageUsecase.getMessage(
                messageStatus: input.msgStatus,
                messageUid: input.msgUuid,
                pairwiseDid: input.pairwiseDid
        )
    }
}
