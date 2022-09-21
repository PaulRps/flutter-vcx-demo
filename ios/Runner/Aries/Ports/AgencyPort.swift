//
//  AgencyPort.swift
//  Runner
//
//  Created by Paulo Silva on 18/08/22.
//

import Foundation
import Combine

protocol AgencyPort {
    func provisionCloudAgency(config: ProvisionAgencyConfigDto) -> Future<String, Error>

    func createAgency(forMainWallet: String) -> Future<String, Error>

    func getMessage(
            connectionHandle: NSNumber?,
            messageStatus: AgencyMessageStatusEnum,
            messageUid: String?
    ) -> Future<String, Error>

    func updateMessageStatus(
            newStaus: AgencyMessageStatusEnum,
            msg: UpdateAgencyMessageStatus
    ) -> Future<Bool, Error>
}
