//
//  Channel.swift
//  Runner
//
//  Created by Paulo Silva on 13/08/22.
//

import Foundation

enum ChannelName: String {
    case ARIES_SDK = "flutter.vcx.demo/aries/sdk"
    case ARIES_MESSAGE = "flutter.vcx.demo/aries/message"
    case ARIES_CONNECTION = "flutter.vcx.demo/aries/connection"
    case ARIES_CREDENTIAL = "flutter.vcx.demo/aries/credential"
    case ARIES_PROOF = "flutter.vcx.demo/aries/proof"
}

class Channel {
    final let listener: ChannelListener
    final let name: ChannelName

    init(_ name: ChannelName, _ listener: ChannelListener) {
        self.name = name
        self.listener = listener
    }

    static let ARIES_SDK: Channel = Channel(.ARIES_SDK, AriesSdkChannelListener())
    static let ARIES_CONNECTION: Channel = Channel(.ARIES_CONNECTION, AriesConnectionChannelListener())
    static let ARIES_MESSAGE: Channel = Channel(.ARIES_MESSAGE, AriesMessageChannelListener())
    static let ARIES_CREDENTIAL: Channel = Channel(.ARIES_CREDENTIAL, AriesCredentialChannelListener())
    static let ARIES_PROOF: Channel = Channel(.ARIES_PROOF, AriesProofChannelListener())

    static func getAll() -> [Channel] {
        [ARIES_SDK, ARIES_CONNECTION, ARIES_MESSAGE, ARIES_CREDENTIAL, ARIES_PROOF]
    }
}
