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

    private final let createOrRecreateConnection: ConnectOrReconnectAriesConnectionUseCase
    private final let createConnectionInvitation: CreateConnectionInvitationUseCase
    private final let checkConnectionInvitationAccepted: CheckConnectionInvitationAcceptedUseCase

    init(
            input: FlutterRequestAriesConnectionChannelDto,
            createOrRecreateConnection: ConnectOrReconnectAriesConnectionUseCase = ConnectOrReconnectAriesConnectionUseCase(),
            createConnectionInvitation: CreateConnectionInvitationUseCase = CreateConnectionInvitationUseCase(),
            checkConnectionInvitationAccepted: CheckConnectionInvitationAcceptedUseCase = CheckConnectionInvitationAcceptedUseCase()
    ) {
        self.input = input
        cancellables = Set()
        self.createOrRecreateConnection = createOrRecreateConnection
        self.createConnectionInvitation = createConnectionInvitation
        self.checkConnectionInvitationAccepted = checkConnectionInvitationAccepted
        setRoutes()
    }

    func setRoutes() {

        routes["create"] = createOrRecreateConnection.connect(
                invitation: input.invitation,
                inviteId: input.inviteId
        )
        routes["invitation"] = createConnectionInvitation.createInvitation()
        routes["checkInvitation"] = checkConnectionInvitationAccepted.checkAndSaveConnection(
                connectionHandle: input.connectionHandle,
                isToReleaseHandle: input.isToDeleteHandle
        )
    }
}
