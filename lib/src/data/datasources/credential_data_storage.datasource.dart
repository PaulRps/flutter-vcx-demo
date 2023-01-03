import 'package:flutter_vcx_demo/src/data/dtos/aries_credential.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/credential_data_encrypted_local_storage.dart';
import 'package:injectable/injectable.dart';

import '../services/local_storage.service.dart';

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
