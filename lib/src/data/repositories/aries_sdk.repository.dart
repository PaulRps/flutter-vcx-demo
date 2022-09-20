import 'package:flutter_vcx_demo/src/data/datasources/aries_sdk.datasource.dart';

import '../dtos/flutter_request_aries_sdk_channel.dto.dart';

abstract class IAriesSdkRepository {
  Future<bool> startSdk(FlutterRequestAriesSdkChannelDto dto);

  Future<bool> shutdownSdk(FlutterRequestAriesSdkChannelDto dto);
}

class AriesSdkRepository implements IAriesSdkRepository {
  late final IAriesSdkDatasource _ariesDatasource;

  AriesSdkRepository({ariesDatasource, ariesGenesisDatasource})
      : _ariesDatasource = ariesDatasource ?? AriesSdkDatasource();

  @override
  Future<bool> startSdk(FlutterRequestAriesSdkChannelDto dto) {
    return _ariesDatasource.startSdk(dto).then((value) => value.success);
  }

  @override
  Future<bool> shutdownSdk(FlutterRequestAriesSdkChannelDto dto) {
    return _ariesDatasource.shutdownSdk(dto).then((value) => value.success);
  }
}
