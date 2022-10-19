//
//  AriesAgencyRepository.swift
//  Runner
//
//  Created by Paulo Silva on 30/08/22.
//

import Foundation
import Combine

class AriesAgencyRepository {

    private final let provisionConfigStorage: ProvisionConfigStoragePort
    private final let agency: AgencyPort

    init(
            provisionConfigStorage: ProvisionConfigStoragePort = ProvisionConfigStorageAdapter(),
            agency: AgencyPort = AriesAgencyAdapter()
    ) {
        self.provisionConfigStorage = provisionConfigStorage
        self.agency = agency
    }

    func provisionCloudAgency(config: ProvisionAgencyConfigDto) -> Future<String, Error> {
        agency.provisionCloudAgency(config: config)
    }

    func createAgencyForMainWallet(provision: String) -> Future<String, Error> {
        agency.createAgency(forMainWallet: provision)
    }

    func getProvisionConfig() -> String {
        provisionConfigStorage.getProvisionData()
    }

    func saveProvisionConfig(config: String?) {
        _ = provisionConfigStorage.save(provisionConfig: config)
    }

    func deleteProvisionConfig() -> Bool {
        provisionConfigStorage.delete()
    }

    func getMessage(
            connectionHandle: NSNumber?,
            messageStatus: AgencyMessageStatusEnum,
            messageUid: String? = ""
    ) -> Future<String, Error> {
        agency.getMessage(
                connectionHandle: connectionHandle,
                messageStatus: messageStatus,
                messageUid: messageUid
        )
    }

    func updateMessageStatus(
            newStaus: AgencyMessageStatusEnum,
            pairwiseDid: String,
            msgUids: [String]
    ) -> Future<Bool, Error> {
        agency.updateMessagesStatus(
                newStaus: newStaus,
                msgs: [UpdateAgencyMessageStatus(
                        pairwiseDID: pairwiseDid,
                        uids: msgUids
                )]
        )
    }
}
