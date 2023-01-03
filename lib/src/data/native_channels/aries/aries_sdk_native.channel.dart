import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

import '../channel.enum.dart';
import '../native_channel.dart';

const String ariesSdkChannel = "ariesSdkChannel";

@Named(ariesSdkChannel)
@LazySingleton(as: INativeChannel)
class AriesSdkNativeChannel extends INativeChannel {
  @override
  Future<dynamic> callMethod(String name, {dynamic argument}) {
    return MethodChannel(
      channel.name,
    ).invokeMethod(name, argument);
  }

  @override
  final ChannelEnum channel = ChannelEnum.ariesSdk;
}
