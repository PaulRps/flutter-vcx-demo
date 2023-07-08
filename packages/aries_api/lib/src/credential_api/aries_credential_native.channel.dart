import 'package:flutter/services.dart';

import '../channel.enum.dart';
import '../native_channel.dart';

const String ariesCredentialChannel = "ariesCredentialChannel";

class AriesCredentialNativeChannel implements INativeChannel {
  @override
  Future callMethod(String name, {argument}) {
    return MethodChannel(
      channel.name,
    ).invokeMethod(name, argument);
  }

  @override
  ChannelEnum get channel => ChannelEnum.ariesCredential;
}
