import 'package:flutter_vcx_demo/src/connections/data/connection_data_encrypted_local_storage.dart';
import 'package:flutter_vcx_demo/src/core/data/local_storage.service.dart';
import 'package:injectable/injectable.dart';

import 'models/models.dart';

abstract class IConnectionDataStorageDatasource {
  Future<void> save(List<ConnectionDataDto> data);

  Future<List<ConnectionDataDto>> get();

  Future<bool> delete();
}

@LazySingleton(as: IConnectionDataStorageDatasource)
class ConnectionDataStorageDatasource
    implements IConnectionDataStorageDatasource {
  final EncryptedLocalStorage<List<ConnectionDataDto>> _localStorage;

  ConnectionDataStorageDatasource(
      @Named(connectionDataStorage) this._localStorage);

  @override
  Future<bool> delete() {
    return _localStorage.delete();
  }

  @override
  Future<List<ConnectionDataDto>> get() {
    return _localStorage.get().then((value) => value ?? []);
  }

  @override
  Future<void> save(List<ConnectionDataDto> data) {
    return _localStorage.save(data);
  }
}
