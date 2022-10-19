//
// Created by Paulo Silva on 09/09/22.
//

import Foundation
import Combine

class AriesProofRepository {
    private final let ariesProof: ProofPort
    private final var cancellables: Set<AnyCancellable>

    init(ariesProof: ProofPort = AriesProofAdapter()) {
        self.ariesProof = ariesProof
        cancellables = Set()
    }


    func getProofRequests(connectionHandle: NSNumber) -> Future<String, Error> {
        ariesProof.getProofRequests(connectionHandle: connectionHandle)
    }

    func createProof(withRequest: String, sourceId: String) -> Future<NSNumber, Error> {
        ariesProof.createProof(withRequest: withRequest, sourceId: sourceId)
    }

    func getCredentialsForProof(proofHandle: NSNumber) -> Future<String, Error> {
        ariesProof.getCredentialsProof(proofHandle: proofHandle)
    }

    func generateProof(
            proofHandle: NSNumber,
            selectedCredentials: String,
            selfAttestedAtt: String
    ) -> Future<NSNumber, Error> {
        ariesProof.generateProof(
                proofHandle: proofHandle,
                selectedCredentials: selectedCredentials,
                selfAttestedAtt: selfAttestedAtt
        )
    }

    func sendProof(
            proofHandle: NSNumber,
            connectionHandle: NSNumber
    ) -> Future<NSNumber, Error> {
        ariesProof.sendProof(
                proofHandle: proofHandle,
                connectionHandle: connectionHandle
        )
    }

    func updateProofState(
            proofHandle: NSNumber,
            connectionHandle: NSNumber
    ) -> Future<AriesFinishedState, Error> {
        ariesProof.updateState(
                proofHandle: proofHandle,
                connectionHandle: connectionHandle
        )
    }

    func getSerializedProof(proofHandle: NSNumber) -> Future<String, Error> {
        ariesProof.getSerializedProof(proofHandle: proofHandle)
    }

    func releaseHandle(proofHandle: NSNumber?) -> Future<NSNumber, Error> {
        Future { promise in
            promise(.success(self.releaseHandle(handle: proofHandle)))
        }
    }

    func releaseHandle(handle: NSNumber?) -> NSNumber {
        ariesProof.releaseHandle(proofHandle: handle)
    }

    func rejectProofRequest(proofHandle: NSNumber, connectionHandle: NSNumber) -> Future<Bool, Error> {
        ariesProof.rejectProofRequest(proofHandle: proofHandle, connectionHandle: connectionHandle)
    }

    func declineProofRequest(
            proofHandle: NSNumber,
            connectionHandle: NSNumber,
            reason: String?,
            proposal: String? = nil
    ) -> Future<Bool, Error> {
        ariesProof.declineProofRequest(
                proofHandle: proofHandle,
                connectionHandle: connectionHandle,
                reason: reason,
                proposal: proposal
        )
    }
}
