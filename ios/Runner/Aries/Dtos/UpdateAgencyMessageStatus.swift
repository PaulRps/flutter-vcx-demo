//
//  UpdateAgencyMessageStatus.swift
//  Runner
//
//  Created by Paulo Silva on 31/08/22.
//

import Foundation

class UpdateAgencyMessageStatus: ToJson {
    var pairwiseDID: String?
    var uids: Array<String>?

    init(pairwiseDID: String?, uids: Array<String>?) {
        self.pairwiseDID = pairwiseDID
        self.uids = uids
    }
}
