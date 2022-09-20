enum ChannelEnum {
  ariesSdk, ariesConnection, ariesMessage, ariesCredential, ariesProof
}

extension ChannelExtension  on ChannelEnum {
  String get name {
    switch(this) {
      case ChannelEnum.ariesSdk: return 'flutter.vcx.demo/aries/sdk';
      case ChannelEnum.ariesConnection: return 'flutter.vcx.demo/aries/connection';
      case ChannelEnum.ariesMessage: return 'flutter.vcx.demo/aries/message';
      case ChannelEnum.ariesCredential: return 'flutter.vcx.demo/aries/credential';
      case ChannelEnum.ariesProof: return 'flutter.vcx.demo/aries/proof';
    }
  }
}