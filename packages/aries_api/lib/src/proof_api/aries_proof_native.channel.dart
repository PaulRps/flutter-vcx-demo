import 'package:flutter/services.dart';

import '../channel.enum.dart';
import '../native_channel.dart';

const String ariesProofChannel = "ariesProofChannel";

class AriesProofNativeChannel implements INativeChannel {
  @override
  Future callMethod(String name, {argument}) {
    return MethodChannel(channel.name).invokeMethod(name, argument);
  }

  @override
  ChannelEnum get channel => ChannelEnum.ariesProof;
}
