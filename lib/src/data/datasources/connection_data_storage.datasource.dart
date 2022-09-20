import 'package:flutter_vcx_demo/src/data/services/connection_data_encrypted_local_storage.dart';
import 'package:flutter_vcx_demo/src/data/services/local_storage.service.dart';

import '../dtos/connection_data.dto.dart';

abstract class IConnectionDataStorageDatasource {
  Future<void> save(ConnectionDataDto data);

  Future<ConnectionDataDto?> get();

  Future<bool> delete();
}

class ConnectionDataStorageDatasource
    implements IConnectionDataStorageDatasource {
  final ILocalStorage<ConnectionDataDto> _localStorage;

  ConnectionDataStorageDatasource({localStorage})
      : _localStorage = localStorage ?? ConnectionDataEncryptedLocalStorage();

  @override
  Future<bool> delete() {
    return _localStorage.delete();
  }

  @override
  Future<ConnectionDataDto?> get() {
    return _localStorage.get();
  }

  @override
  Future<void> save(ConnectionDataDto data) {
    return _localStorage.save(data);
  }
}
