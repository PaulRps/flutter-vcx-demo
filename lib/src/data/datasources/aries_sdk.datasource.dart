import 'package:flutter_vcx_demo/src/data/dtos/aries_sdk_start_response.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';

import '../dtos/flutter_request_aries_sdk_channel.dto.dart';
import '../native_channels/aries/aries_sdk_native.channel.dart';
import '../services/aries_sdk.service.dart';

abstract class IAriesSdkDatasource {
  Future<AriesSdkStartResponse> startSdk(FlutterRequestAriesSdkChannelDto dto);

  Future<NativeToFlutterResponseDto> shutdownSdk(
      FlutterRequestAriesSdkChannelDto dto);
}

class AriesSdkDatasource implements IAriesSdkDatasource {
  late final IAriesSdkService _ariesService;

  AriesSdkDatasource({ariesProvider, ariesGenesisDatasource})
      : _ariesService = ariesProvider ?? AriesSdkService(AriesNativeChannel());

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
