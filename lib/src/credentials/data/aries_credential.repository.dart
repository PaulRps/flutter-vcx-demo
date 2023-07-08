import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/credentials/data/data.dart';
import 'package:flutter_vcx_demo/src/credentials/domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'credential.converter.dart';
import 'credential_data_storage.datasource.dart';

@LazySingleton(as: ICredentialRepository)
class AriesCredentialRepository implements ICredentialRepository {
  late final IAriesCredentialDatasource _ariesCredentialDatasource;
  late final ICredentialDataDatasource _credentialDataDatasource;
  late final CredentialConverter _converter;

  AriesCredentialRepository(this._ariesCredentialDatasource,
      this._credentialDataDatasource, this._converter);

  @override
  Future<Credential> acceptCredentialOffer(
      {required String pairwiseDid, required String sourceId}) {
    if (pairwiseDid.isEmpty == true) {
      return Future.error("pairwiseDid is required");
    }

    if (sourceId.isEmpty == true) {
      return Future.error("sourceId is required");
    }

    return _ariesCredentialDatasource
        .acceptCredentialOffer(FlutterRequestAriesCredentialChannelDto(
            pairwiseDid: pairwiseDid, sourceId: "flutterVcxDemo"))
        .then((value) => value as Credential);
  }

  @override
  Future<List<Credential>> getCredentials() {
    return _ariesCredentialDatasource.getCredentials().then((value) =>
        _converter.toCredentialList(
            (value as AriesGetCredentialsResponseDto).credentials));
  }

  @override
  Future<List<Credential>> getCredentialsData() {
    return _credentialDataDatasource.get().then((value) =>
        value?.map((e) => _converter.toCredential(e)).toList() ?? []);
  }

  @override
  Future<void> saveCredentialData(Credential data) {
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
