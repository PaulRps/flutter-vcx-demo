import 'package:flutter/services.dart';

import '../channel.enum.dart';
import '../native_channel.dart';

const String ariesMessageChannel = "ariesMessageChannel";

class AriesMessageNativeChannel implements INativeChannel {
  @override
  ChannelEnum get channel => ChannelEnum.ariesMessage;

  @override
  Future callMethod(String name, {argument}) {
    return MethodChannel(
      channel.name,
    ).invokeMethod(name, argument);
  }
}
