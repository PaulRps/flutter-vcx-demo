//
// Created by Paulo Silva on 09/09/22.
//

import Foundation
import Combine

protocol ProofPort {
    func getProofRequests(connectionHandle: NSNumber) -> Future<String, Error>

    func createProof(withRequest: String, sourceId: String) -> Future<NSNumber, Error>

    func getCredentialsProof(proofHandle: NSNumber) -> Future<String, Error>

    func generateProof(
            proofHandle: NSNumber,
            selectedCredentials: String,
            selfAttestedAtt: String
    ) -> Future<NSNumber, Error>

    func sendProof(
            proofHandle: NSNumber,
            connectionHandle: NSNumber
    ) -> Future<NSNumber, Error>

    func releaseHandle(proofHandle: NSNumber?) -> NSNumber

    func updateState(
            proofHandle: NSNumber,
            connectionHandle: NSNumber
    ) -> Future<AriesFinishedState, Error>

    func getSerializedProof(proofHandle: NSNumber) -> Future<String, Error>

    func rejectProofRequest(proofHandle: NSNumber, connectionHandle: NSNumber) -> Future<Bool, Error>

    func declineProofRequest(
            proofHandle: NSNumber,
            connectionHandle: NSNumber,
            reason: String?,
            proposal: String?
    ) -> Future<Bool, Error>
}
