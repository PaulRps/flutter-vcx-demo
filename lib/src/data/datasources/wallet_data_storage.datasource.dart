import 'package:flutter_vcx_demo/src/data/dtos/wallet_data.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/local_storage.service.dart';

abstract class IWalletDataStorageDatasource {
  Future<void> save(WalletDataDto data);

  Future<WalletDataDto?> get();

  Future<bool> delete();
}

class WalletDataStorageDatasource implements IWalletDataStorageDatasource {
  late final ILocalStorage<WalletDataDto> _localWalletDataStorage;

  WalletDataStorageDatasource(this._localWalletDataStorage);

  @override
  Future<void> save(WalletDataDto data) {
    return _localWalletDataStorage.save(data);
  }

  @override
  Future<WalletDataDto?> get() {
    return _localWalletDataStorage.get();
  }

  @override
  Future<bool> delete() {
    return _localWalletDataStorage.delete();
  }
}
