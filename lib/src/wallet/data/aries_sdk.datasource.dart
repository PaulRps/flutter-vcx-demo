import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

import 'aries_sdk.service.dart';

abstract class IAriesSdkDatasource {
  Future<AriesSdkStartResponse> startSdk(FlutterRequestAriesSdkChannelDto dto);

  Future<NativeToFlutterResponseDto> shutdownSdk(
      FlutterRequestAriesSdkChannelDto dto);
}

@LazySingleton(as: IAriesSdkDatasource)
class AriesSdkDatasource implements IAriesSdkDatasource {
  late final IAriesSdkService _ariesService;

  AriesSdkDatasource(this._ariesService);

  @override
  Future<AriesSdkStartResponse> startSdk(FlutterRequestAriesSdkChannelDto dto) {
    return _ariesService.startSdk(dto).then((value) {
      return AriesSdkStartResponse.fromJson(value);
    });
  }

  @override
  Future<NativeToFlutterResponseDto> shutdownSdk(
      FlutterRequestAriesSdkChannelDto dto) {
    return _ariesService.shutdownSdk(dto).then((value) {
      return NativeToFlutterResponseDto.fromJson(value);
    });
  }
}
