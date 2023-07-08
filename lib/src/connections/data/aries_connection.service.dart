import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesConnectionService {
  Future<dynamic> createConnection(FlutterRequestAriesConnectionChannelDto dto);

  Future<dynamic> createConnectionInvitation();

  Future<dynamic> checkConnectionInvitation(
      FlutterRequestAriesConnectionChannelDto dto);
}

@LazySingleton(as: IAriesConnectionService)
class AriesConnectionService implements IAriesConnectionService {
  late final AriesConnectionApi _ariesConnectionApi;

  AriesConnectionService(this._ariesConnectionApi);

  @override
  Future<dynamic> createConnection(
      FlutterRequestAriesConnectionChannelDto dto) {
    return _ariesConnectionApi.createConnection(dto);
  }

  @override
  Future checkConnectionInvitation(
      FlutterRequestAriesConnectionChannelDto dto) {
    return _ariesConnectionApi.checkConnectionInvitation(dto);
  }

  @override
  Future createConnectionInvitation() {
    return _ariesConnectionApi.createConnectionInvitation();
  }
}
