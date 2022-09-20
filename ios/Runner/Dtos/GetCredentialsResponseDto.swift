//
// Created by Paulo Silva on 16/09/22.
//

import Foundation

class GetCredentialsResponseDto: NativeToFlutterResponseDto {
    final var credentials: [CredentialDto] = []

    static func create(from: [SearchRecordDto]) -> GetCredentialsResponseDto {
        let result = GetCredentialsResponseDto(success: true)

        result.credentials = from.map { cred in
            CredentialDto.create(from: cred)
        }

        return result
    }

    override func toMap() -> [String: Any] {
        var map = super.toMap()

        if !credentials.isEmpty {
            map["credentials"] = credentials.map { cred in
                cred.toMap()
            }
        }

        return map
    }
}

class CredentialDto {
    final let name: String

    init(name: String) {
        self.name = name
    }

    static func create(from: SearchRecordDto) -> CredentialDto {
        CredentialDto(name: "\(from.tags?["name"]):\(from.tags?["version"])")
    }

    func toMap() -> [String: String] {
        ["name": name]
    }
}
