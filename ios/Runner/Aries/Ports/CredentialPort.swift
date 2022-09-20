//
// Created by Paulo Silva on 05/09/22.
//

import Foundation
import Combine

protocol CredentialPort {
    func getOffers(connectionHandle: NSNumber) -> Future<String, Error>

    func createCredential(withOffer: String, sourceId: String) -> Future<NSNumber, Error>

    func sendRequest(
            credentialHandle: NSNumber,
            connectionHandle: NSNumber,
            paymentHandle: NSNumber
    ) -> Future<NSNumber, Error>

    func getSerializedCredential(credentialHandle: NSNumber) -> Future<String, Error>

    func releaseHandle(handle: NSNumber?) -> NSNumber

    func updateState(
            credentialHandle: NSNumber,
            connectionHandle: NSNumber
    ) -> Future<AriesFinishedState, Error>
}