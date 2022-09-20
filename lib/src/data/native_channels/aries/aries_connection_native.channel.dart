import 'package:flutter/services.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/channel.enum.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';

class AriesConnectionNativeChannel implements INativeChannel {
  @override
  Future callMethod(String name, {argument}) {
    return MethodChannel(
      channel.name,
    ).invokeMethod(name, argument);
  }

  @override
  ChannelEnum get channel => ChannelEnum.ariesConnection;

}