//
//  AriesConnectionMethodResolver.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

class AriesConnectionMethodResolver: MethodResolver {
    typealias I = FlutterRequestAriesConnectionChannelDto
    final let input: FlutterRequestAriesConnectionChannelDto
    final var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>]
    
    var logger = CustomLogger(context: AriesConnectionMethodResolver.self)
    private final var cancellables:Set<AnyCancellable>
    
    private final let createOrRecreateConnectionUsecase: ConnectOrReconnectAriesConnectionUsecase
    
    init(
        input: FlutterRequestAriesConnectionChannelDto,
        createOrRecreateConnectionUsecase: ConnectOrReconnectAriesConnectionUsecase=ConnectOrReconnectAriesConnectionUsecase()
    ) {
        self.input = input
        self.cancellables = Set()
        self.routes = [:]
        self.createOrRecreateConnectionUsecase = createOrRecreateConnectionUsecase
        self.setRoutes()
    }
    
    func setRoutes() {
        
        self.routes["create"] =  self.createOrRecreateConnectionUsecase.connect(
            invitation: self.input.invitation!,
            inviteId: self.input.inviteId!
        )
        
    }
}
