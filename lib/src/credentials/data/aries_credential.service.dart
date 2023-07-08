import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesCredentialService {
  Future acceptCredentialOffer(FlutterRequestAriesCredentialChannelDto dto);

  Future getCredentials();
}

@LazySingleton(as: IAriesCredentialService)
class AriesCredentialService implements IAriesCredentialService {
  late final AriesCredentialApi _ariesCredentialApi;

  AriesCredentialService(this._ariesCredentialApi);

  @override
  Future acceptCredentialOffer(FlutterRequestAriesCredentialChannelDto dto) {
    return _ariesCredentialApi.acceptCredentialOffer(dto);
  }

  @override
  Future getCredentials() {
    return _ariesCredentialApi.getCredentials();
  }
}
