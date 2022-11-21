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

    private final let createOrRecreateConnection: InviteeConnectOrReconnectWithInvitationUseCase
    private final let createConnectionInvitation: InviterCreateConnectionInvitationUseCase
    private final let checkConnectionInvitationAccepted: InviterCheckConnectionInvitationWasAcceptedUseCase

    init(
            input: FlutterRequestAriesConnectionChannelDto,
            createOrRecreateConnection: InviteeConnectOrReconnectWithInvitationUseCase = InviteeConnectOrReconnectWithInvitationUseCase(),
            createConnectionInvitation: InviterCreateConnectionInvitationUseCase = InviterCreateConnectionInvitationUseCase(),
            checkConnectionInvitationAccepted: InviterCheckConnectionInvitationWasAcceptedUseCase = InviterCheckConnectionInvitationWasAcceptedUseCase()
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
