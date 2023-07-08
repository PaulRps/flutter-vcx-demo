import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/core/core.dart';
import 'package:flutter_vcx_demo/src/credentials/data/credential_data_encrypted_local_storage.dart';
import 'package:injectable/injectable.dart';

abstract class ICredentialDataDatasource {
  Future<void> save(List<AriesCredentialDto> data);

  Future<List<AriesCredentialDto>?> get();

  Future<bool> delete();
}

@LazySingleton(as: ICredentialDataDatasource)
class CredentialDataDatasource implements ICredentialDataDatasource {
  late final EncryptedLocalStorage<List<AriesCredentialDto>> _localStorage;

  CredentialDataDatasource(@Named(credentialDataStorage) this._localStorage);

  @override
  Future<bool> delete() {
    return _localStorage.delete();
  }

  @override
  Future<List<AriesCredentialDto>?> get() {
    return _localStorage.get();
  }

  @override
  Future<void> save(List<AriesCredentialDto> data) {
    return _localStorage.save(data);
  }
}
