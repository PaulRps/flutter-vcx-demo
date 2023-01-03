import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_connection_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/aries/aries_connection_native.channel.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesConnectionService {
  Future<dynamic> createConnection(FlutterRequestAriesConnectionChannelDto dto);

  Future<dynamic> createConnectionInvitation();

  Future<dynamic> checkConnectionInvitation(
      FlutterRequestAriesConnectionChannelDto dto);
}

@LazySingleton(as: IAriesConnectionService)
class AriesConnectionService implements IAriesConnectionService {
  late final INativeChannel _channel;

  AriesConnectionService(@Named(ariesConnectionChannel) this._channel);

  @override
  Future<dynamic> createConnection(
      FlutterRequestAriesConnectionChannelDto dto) {
    return _channel.callMethod("create", argument: dto.toJson());
  }

  @override
  Future checkConnectionInvitation(
      FlutterRequestAriesConnectionChannelDto dto) {
    return _channel.callMethod("checkInvitation", argument: dto.toJson());
  }

  @override
  Future createConnectionInvitation() {
    return _channel.callMethod("invitation");
  }
}
