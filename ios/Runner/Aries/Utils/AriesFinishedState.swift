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
        ConnectionStateEnum.FINISHED == state
    }
}

class AriesCredentialHolderFinishedState: AriesFinishedState {
    private final let state: CredentialHolderStateEnum

    init(state: CredentialHolderStateEnum) {
        self.state = state
    }

    func isFinished() -> Bool {
        CredentialHolderStateEnum.FINISHED == state
    }
}

class AriesCredentialIssuerFinishedState: AriesFinishedState {
    private final let state: CredentialIssuerStateEnum

    init(state: CredentialIssuerStateEnum) {
        self.state = state
    }

    func isFinished() -> Bool {
        CredentialIssuerStateEnum.FINISHED == state
    }
}

class AriesProofProverFinishedState: AriesFinishedState {
    private final let state: ProofProverStateEnum

    init(state: ProofProverStateEnum) {
        self.state = state
    }

    func isFinished() -> Bool {
        state == .FINISHED
    }
}

class AriesProofVerifierFinishedState: AriesFinishedState {
    private final let state: ProofVerifierStateEnum

    init(state: ProofVerifierStateEnum) {
        self.state = state
    }

    func isFinished() -> Bool {
        state == .FINISHED
    }
}
