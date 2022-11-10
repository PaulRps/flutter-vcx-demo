//
// Created by Paulo Silva on 04/11/22.
//

import Foundation

class ProofRequestRevocationIntervalDto: ToJson {
    let to: Double?
    let from: Double?

    init(to: Double? = nil, from: Double? = nil) {
        self.to = to
        self.from = from
    }
}
