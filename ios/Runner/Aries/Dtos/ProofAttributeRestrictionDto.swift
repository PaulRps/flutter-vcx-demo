//
// Created by Paulo Silva on 04/11/22.
//

import Foundation

class ProofAttributeRestrictionDto: ToJson {
    let schemaId: String?
    let schemaIssuerDid: String?
    let schemaName: String?
    let schemaVersion: String?
    let issuerDid: String?
    let credentialDefinitionId: String?

    init(
            schemaId: String? = nil,
            schemaIssuerDid: String? = nil,
            schemaName: String? = nil,
            schemaVersion: String? = nil,
            issuerDid: String? = nil,
            credentialDefinitionId: String? = nil
    ) {
        self.schemaId = schemaId
        self.schemaIssuerDid = schemaIssuerDid
        self.schemaName = schemaName
        self.schemaVersion = schemaVersion
        self.issuerDid = issuerDid
        self.credentialDefinitionId = credentialDefinitionId
    }

    enum CodingKeys: String, CodingKey {
        case schemaId = "schema_id"
        case schemaIssuerDid = "schema_issuer_did"
        case schemaName = "schema_name"
        case schemaVersion = "schema_version"
        case issuerDid = "issuer_did"
        case credentialDefinitionId = "cred_def_id"
    }
}
