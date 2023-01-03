import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_message_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/aries/aries_message_native.channel.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesMessageService {
  Future<dynamic> getMessageByPwDid(FlutterRequestAriesMessageChannelDto dto);
}

@LazySingleton(as: IAriesMessageService)
class AriesMessageService implements IAriesMessageService {
  final INativeChannel _channel;

  AriesMessageService(@Named(ariesMessageChannel) this._channel);

  @override
  Future<dynamic> getMessageByPwDid(FlutterRequestAriesMessageChannelDto dto) {
    return _channel.callMethod("getOneByPwDid", argument: dto.toJson());
  }
}
