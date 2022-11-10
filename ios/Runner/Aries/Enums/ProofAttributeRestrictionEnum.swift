//
// Created by Paulo Silva on 04/11/22.
//

import Foundation

enum ProofAttributeRestrictionEnum {
    case array([ProofAttributeRestrictionDto])
    case one(ProofAttributeRestrictionDto)
}

extension ProofAttributeRestrictionEnum: Codable {
    enum Key: CodingKey {
        case rawValue
        case associatedValue
    }

    enum CodingError: Error {
        case unknownValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            let array = try container.decode([ProofAttributeRestrictionDto].self, forKey: .associatedValue)
            self = .array(array)
        case 1:
            let one = try container.decode(ProofAttributeRestrictionDto.self, forKey: .associatedValue)
            self = .one(one)
        default:
            throw CodingError.unknownValue
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .array(let restrictions):
            try container.encode(0, forKey: .rawValue)
            try container.encode(restrictions, forKey: .associatedValue)
        case .one(let restriction):
            try container.encode(1, forKey: .rawValue)
            try container.encode(restriction, forKey: .associatedValue)
        }
    }
}
