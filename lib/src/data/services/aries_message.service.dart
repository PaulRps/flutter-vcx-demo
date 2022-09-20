import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_message_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/aries/aries_message_native.channel.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';

abstract class IAriesMessageService {
  Future<dynamic> getMessageByPwDid(FlutterRequestAriesMessageChannelDto dto);
}

class AriesMessageService implements IAriesMessageService {
  final INativeChannel _channel;

  AriesMessageService({channel})
      : _channel = channel ?? AriesMessageNativeChannel();

  @override
  Future<dynamic> getMessageByPwDid(FlutterRequestAriesMessageChannelDto dto) {
    return _channel.callMethod("getOneByPwDid", argument: dto.toJson());
  }
}
