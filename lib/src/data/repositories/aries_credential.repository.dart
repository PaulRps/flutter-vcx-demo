import 'package:flutter_vcx_demo/src/data/datasources/aries_credential.datasource.dart';
import 'package:flutter_vcx_demo/src/data/datasources/credential_data_storage.datasource.dart';
import 'package:flutter_vcx_demo/src/data/dtos/aries_credential.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/aries_get_credentials_response.dto.dart';
import 'package:flutter_vcx_demo/src/domain/entities/credential_data.dart';
import 'package:injectable/injectable.dart';

import '../dtos/aries_accept_credential_offer_response.dto.dart';
import '../dtos/flutter_request_aries_credential_channel.dto.dart';

abstract class IAriesCredentialRepository {
  Future<AriesAcceptCredentialOfferResponseDto> acceptCredentialOffer(
      FlutterRequestAriesCredentialChannelDto dto);

  Future<AriesGetCredentialsResponseDto> getCredentials();

  Future<List<CredentialData>> getCredentialsData();

  Future<void> saveCredentialData(CredentialData data);

  Future<bool> deleteCredentialsData();
}

@LazySingleton(as: IAriesCredentialRepository)
class AriesCredentialRepository implements IAriesCredentialRepository {
  late final IAriesCredentialDatasource _ariesCredentialDatasource;
  late final ICredentialDataDatasource _credentialDataDatasource;

  AriesCredentialRepository(
      this._ariesCredentialDatasource, this._credentialDataDatasource);

  @override
  Future<AriesAcceptCredentialOfferResponseDto> acceptCredentialOffer(
      FlutterRequestAriesCredentialChannelDto dto) {
    if (dto.pairwiseDid?.isEmpty == true) {
      return Future.error("pairwiseDid is required");
    }

    if (dto.sourceId?.isEmpty == true) {
      return Future.error("sourceId is required");
    }

    return _ariesCredentialDatasource
        .acceptCredentialOffer(dto)
        .then((value) => value as AriesAcceptCredentialOfferResponseDto);
  }

  @override
  Future<AriesGetCredentialsResponseDto> getCredentials() {
    return _ariesCredentialDatasource
        .getCredentials()
        .then((value) => value as AriesGetCredentialsResponseDto);
  }

  @override
  Future<List<CredentialData>> getCredentialsData() {
    return _credentialDataDatasource.get().then(
        (value) => value?.map((e) => CredentialData(e.name)).toList() ?? []);
  }

  @override
  Future<void> saveCredentialData(CredentialData data) {
    if (data.name.isEmpty) return Future.value();
    return _credentialDataDatasource.get().then((credentials) {
      var list = credentials ?? [];
      list.add(AriesCredentialDto(data.name));
      return _credentialDataDatasource.save(list);
    });
  }

  @override
  Future<bool> deleteCredentialsData() {
    return _credentialDataDatasource.delete();
  }
}
