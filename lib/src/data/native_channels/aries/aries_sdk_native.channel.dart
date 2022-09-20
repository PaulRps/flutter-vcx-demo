import 'package:flutter/services.dart';

import '../channel.enum.dart';
import '../native_channel.dart';

class AriesNativeChannel extends INativeChannel {
  @override
  Future<dynamic> callMethod(String name, {dynamic argument}) {
    return MethodChannel(
      channel.name,
    ).invokeMethod(name, argument);
  }

  @override
  final ChannelEnum channel = ChannelEnum.ariesSdk;
}
