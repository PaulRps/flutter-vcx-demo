//
//  AriesConnectionPort.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation
import Combine

protocol ConnectionPort {

    func updateState(connectionHandle: NSNumber) -> Future<AriesFinishedState, Error>

    func getSerializedConnection(connectionHandle: NSNumber) -> Future<String, Error>

    func getConnectionHandle(serializedConnection: String?) -> Future<NSNumber, Error>

    func releaseHandle(handle: NSNumber?) -> NSNumber

    func connectionCreateWithInvite(
            inviteId: String,
            invitation: ConnectionInvitationDto
    ) -> Future<NSNumber, Error>

    func create(sourceId: String) -> Future<NSNumber, Error>

    func connectionConnect(
            connectionHandle: NSNumber,
            connectionOptions: ConnectionOptionsDto
    ) -> Future<String, Error>

    func inviteDetails(connectionHandle: NSNumber) -> Future<String, Error>
}
