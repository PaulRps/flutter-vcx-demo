//
//  AriesConnectionMethodResolver.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

class AriesConnectionRouter: Router {
    typealias I = FlutterRequestAriesConnectionChannelDto
    final let input: FlutterRequestAriesConnectionChannelDto
    final var routes: [String: AnyPublisher<NativeToFlutterResponseDto, Error>] = [:]

    var logger = CustomLogger(context: AriesConnectionRouter.self)
    private final var cancellables: Set<AnyCancellable>

    private final let createOrRecreateConnectionUsecase: ConnectOrReconnectAriesConnectionUsecase

    init(
            input: FlutterRequestAriesConnectionChannelDto,
            createOrRecreateConnectionUsecase: ConnectOrReconnectAriesConnectionUsecase = ConnectOrReconnectAriesConnectionUsecase()
    ) {
        self.input = input
        cancellables = Set()
        self.createOrRecreateConnectionUsecase = createOrRecreateConnectionUsecase
        setRoutes()
    }

    func setRoutes() {

        routes["create"] = createOrRecreateConnectionUsecase.connect(
                invitation: input.invitation!,
                inviteId: input.inviteId!
        )
        routes["invitation"] = CreateConnectionInvitationUsecase().createInvitation()
        routes["checkInvitation"] = CheckConnectionInvitationAcceptedUsecase().checkAndSaveConnection(
                connectionHandle: input.connectionHandle
        )
    }
}
