import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesSdkService {
  Future<dynamic> startSdk(FlutterRequestAriesSdkChannelDto dto);

  Future<dynamic> shutdownSdk(FlutterRequestAriesSdkChannelDto dto);
}

@LazySingleton(as: IAriesSdkService)
class AriesSdkService implements IAriesSdkService {
  late final AriesSdkApi _ariesSdkApi;

  AriesSdkService(this._ariesSdkApi);

  @override
  Future<dynamic> startSdk(FlutterRequestAriesSdkChannelDto dto) {
    return _ariesSdkApi.startSdk(dto.toJson());
  }

  @override
  Future<dynamic> shutdownSdk(FlutterRequestAriesSdkChannelDto dto) {
    return _ariesSdkApi.shutdownSdk(dto.toJson());
  }
}
