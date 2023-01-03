import 'package:flutter/services.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/channel.enum.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';
import 'package:injectable/injectable.dart';

const String ariesCredentialChannel = "ariesCredentialChannel";

@Named(ariesCredentialChannel)
@LazySingleton(as: INativeChannel)
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
