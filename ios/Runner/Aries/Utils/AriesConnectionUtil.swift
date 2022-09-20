//
//  AriesConnectionUtil.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

class AriesConnectionUtil {
    static func connectionStateIs(state: ConnectionStateEnum?, connection: SearchRecordDto?) -> Bool {
        if (state == nil || connection == nil || connection?.tags == nil) {
            return false
        }
        let state = connection!.tags!["state"]!
        let connectionState = ConnectionStateEnum.getOne(value: state)
        return connectionState == ConnectionStateEnum.ACCEPTED
    }

    static func isConnectionFinished(connection: SearchRecordDto?) -> Bool {
        connectionStateIs(
                state: ConnectionStateEnum.ACCEPTED,
                connection: connection
        )
    }
}
