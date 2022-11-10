//
// Created by Paulo Silva on 04/11/22.
//

import Foundation

class ProofRequestDto {
    let sourceId: String
    let attributes: [ProofRequestedAttributeDto]
    let predicates: [ProofPredicateDto]
    let name: String
    let revocationInterval: ProofRequestRevocationIntervalDto

    init(
            sourceId: String,
            attributes: [ProofRequestedAttributeDto],
            predicates: [ProofPredicateDto],
            name: String,
            revocationInterval: ProofRequestRevocationIntervalDto
    ) {
        self.sourceId = sourceId
        self.attributes = attributes
        self.predicates = predicates
        self.name = name
        self.revocationInterval = revocationInterval
    }
}
