//
//  AriesMessageMethodResolver.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation
import Combine

class AriesMessageMethodResolver: MethodResolver {
    let logger = CustomLogger(context: AriesMessageMethodResolver.self)
    typealias I = FlutterRequestAriesMessageChannelDto
    let input: FlutterRequestAriesMessageChannelDto
    var routes: [String : AnyPublisher<NativeToFlutterResponseDto, Error>]=[:]
    
    private final let getMessageUsecase: GetMessageByConnectionFromAriesAgencyUsecase
    
    init(
        input: FlutterRequestAriesMessageChannelDto,
        getMessageUsecase: GetMessageByConnectionFromAriesAgencyUsecase
    ) {
        self.input = input
        self.getMessageUsecase = getMessageUsecase
        self.setRoutes()
    }
    
    private func setRoutes() {
        self.routes["getOneByPwDid"] = self.getMessageUsecase.getMessage(
            messageStatus: self.input.msgStatus,
            messageUid: self.input.msgUuid,
            pairwiseDid: self.input.pairwiseDid
        )
    }
}
