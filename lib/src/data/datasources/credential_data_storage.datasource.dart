import 'package:flutter_vcx_demo/src/data/dtos/aries_credential.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/credential_data_encrypted_local_storage.dart';

abstract class ICredentialDataDatasource {
  Future<void> save(List<AriesCredentialDto> data);

  Future<List<AriesCredentialDto>?> get();

  Future<bool> delete();
}

class CredentialDataDatasource implements ICredentialDataDatasource {
  late final CredentialDataEncryptedLocalStorage _localStorage;

  CredentialDataDatasource({localStorage})
      : _localStorage = localStorage ?? CredentialDataEncryptedLocalStorage();

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
