import 'package:flutter_vcx_demo/src/data/dtos/aries_accept_credential_offer_response.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/aries_get_credentials_response.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_credential_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/aries_credential.service.dart';
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
