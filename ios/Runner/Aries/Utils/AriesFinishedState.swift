//
//  AriesFinishedState.swift
//  Runner
//
//  Created by Paulo Silva on 26/08/22.
//

import Foundation

protocol AriesFinishedState {
    func isFinished() -> Bool
}

class AriesConnectionFinishedState: AriesFinishedState {
    private final let state: ConnectionStateEnum

    init(state: ConnectionStateEnum) {
        self.state = state
    }

    func isFinished() -> Bool {
        ConnectionStateEnum.ACCEPTED == state
    }
}

class AriesCredentialFinishedState: AriesFinishedState {
    private final let state: CredentialStateEnum

    init(state: CredentialStateEnum) {
        self.state = state
    }

    func isFinished() -> Bool {
        CredentialStateEnum.FINISHED == state
    }
}

class AriesProofFinishedState: AriesFinishedState {
    private final let state: ProofStateEnum

    init(state: ProofStateEnum) {
        self.state = state
    }

    func isFinished() -> Bool {
        state == .FINISHED
    }

}
