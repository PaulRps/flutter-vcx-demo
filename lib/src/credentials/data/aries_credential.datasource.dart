import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/credentials/data/aries_credential.service.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesCredentialDatasource {
  Future<NativeToFlutterResponseDto> acceptCredentialOffer(
      FlutterRequestAriesCredentialChannelDto dto);

  Future<NativeToFlutterResponseDto> getCredentials();
}

@LazySingleton(as: IAriesCredentialDatasource)
class AriesCredentialDatasource implements IAriesCredentialDatasource {
  late final IAriesCredentialService _ariesCredentialService;

  AriesCredentialDatasource(this._ariesCredentialService);

  @override
  Future<NativeToFlutterResponseDto> acceptCredentialOffer(
      FlutterRequestAriesCredentialChannelDto dto) {
    return _ariesCredentialService
        .acceptCredentialOffer(dto)
        .then((value) => AriesAcceptCredentialOfferResponseDto.fromJson(value));
  }

  @override
  Future<NativeToFlutterResponseDto> getCredentials() {
    return _ariesCredentialService
        .getCredentials()
        .then((value) => AriesGetCredentialsResponseDto.fromJson(value));
  }
}
