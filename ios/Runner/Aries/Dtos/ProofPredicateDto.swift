//
// Created by Paulo Silva on 04/11/22.
//

import Foundation

class ProofPredicateDto: ToJson {
    let name: String
    let type: ProofPredicateTypeEnum
    let value: NSInteger
    let restrictions: [ProofAttributeRestrictionDto]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type = "p_type"
        case value = "p_value"
        case restrictions = "restrictions"
    }

    init(
            name: String,
            type: ProofPredicateTypeEnum,
            value: NSInteger,
            restrictions: [ProofAttributeRestrictionDto]
    ) {
        self.name = name
        self.type = type
        self.value = value
        self.restrictions = restrictions
    }
}
