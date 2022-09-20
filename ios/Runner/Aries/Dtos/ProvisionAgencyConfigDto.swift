//
//  ProvisionAgencyConfigDto.swift
//  Runner
//
//  Created by Paulo Silva on 15/08/22.
//

import Foundation

class ProvisionAgencyConfigDto: ToJson {
    final let agencyEndpoint: String?
    
    final let agencyDid: String?
    
    final let agencyVerkey: String?
    
    final let institutionName: String?
    
    init(
        agencyEndpoint: String?,
        agencyDid: String?,
        agencyVerkey: String?,
        institutionName: String?=nil
        
    ) {
        self.agencyEndpoint = agencyEndpoint
        self.agencyDid = agencyDid
        self.agencyVerkey = agencyVerkey
        self.institutionName = institutionName
    }
    
    enum CodingKeys: String, CodingKey {
        case agencyEndpoint = "agency_endpoint"
        case agencyDid = "agency_did"
        case agencyVerkey = "agency_verkey"
        case institutionName = "institution_name"
    }
    
    static func from(provisionConfig: [String:AnyObject]?) -> ProvisionAgencyConfigDto {
        return ProvisionAgencyConfigDto(
            agencyEndpoint: provisionConfig?["agencyEndpoint"] as? String,
            agencyDid: provisionConfig?["agencyDid"] as? String,
            agencyVerkey: provisionConfig?["agencyVerkey"] as? String,
            institutionName: provisionConfig?["institutionName"] as? String
        )
    }
}
