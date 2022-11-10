//
// Created by Paulo Silva on 04/11/22.
//

import Foundation

/**
 * @description This represents one attribute expected for user to prove.
 * A list of these attributes will be composed of all requirements for user to prove.
 * @interface
 */
class ProofRequestedAttributeDto: ToJson {
    let name: String?

    // Requested attribute names. Can be used to specify several attributes that have to match a single credential.
    // NOTE: should either be "name" or "names", not both and not none of them.
    let names: String?

    let restrictions: [ProofAttributeRestrictionDto]

    init(
            restrictions: [ProofAttributeRestrictionDto],
            name: String? = nil,
            names: String? = nil
    ) {
        self.name = name
        self.names = names
        self.restrictions = restrictions
    }
}
