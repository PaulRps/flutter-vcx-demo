import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_connection_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/aries/aries_connection_native.channel.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';

abstract class IAriesConnectionService {
  Future<dynamic> createConnection(FlutterRequestAriesConnectionChannelDto dto);
}

class AriesConnectionService implements IAriesConnectionService {
  late final INativeChannel _channel;

  AriesConnectionService({channel})
      : _channel = channel ?? AriesConnectionNativeChannel();

  @override
  Future<dynamic> createConnection(
      FlutterRequestAriesConnectionChannelDto dto) {
    return _channel.callMethod("create", argument: dto.toJson());
  }
}
