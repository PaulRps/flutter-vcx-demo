import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_sdk_channel.dto.dart';

import '../native_channels/native_channel.dart';

abstract class IAriesSdkService {
  Future<dynamic> startSdk(FlutterRequestAriesSdkChannelDto dto);

  Future<dynamic> shutdownSdk(FlutterRequestAriesSdkChannelDto dto);
}

class AriesSdkService implements IAriesSdkService {
  late final INativeChannel _nativeChannel;

  AriesSdkService(this._nativeChannel);

  @override
  Future<dynamic> startSdk(FlutterRequestAriesSdkChannelDto dto) {
    return _nativeChannel.callMethod("start", argument: dto.toJson());
  }

  @override
  Future<dynamic> shutdownSdk(FlutterRequestAriesSdkChannelDto dto) {
    return _nativeChannel.callMethod("shutdown", argument: dto.toJson());
  }
}
