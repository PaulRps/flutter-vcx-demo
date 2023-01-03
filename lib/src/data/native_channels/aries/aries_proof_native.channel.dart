import 'package:flutter/services.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/channel.enum.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';
import 'package:injectable/injectable.dart';

const String ariesProofChannel = "ariesProofChannel";

@Named(ariesProofChannel)
@LazySingleton(as: INativeChannel)
class AriesProofNativeChannel implements INativeChannel {
  @override
  Future callMethod(String name, {argument}) {
    return MethodChannel(channel.name).invokeMethod(name, argument);
  }

  @override
  ChannelEnum get channel => ChannelEnum.ariesProof;
}
