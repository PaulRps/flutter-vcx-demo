import 'package:flutter_vcx_demo/src/data/dtos/wallet_data.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/local_storage.service.dart';
import 'package:injectable/injectable.dart';

import '../services/wallet_data_encrypted_local_storage.dart';

abstract class IWalletDataStorageDatasource {
  Future<void> save(WalletDataDto data);

  Future<WalletDataDto?> get();

  Future<bool> delete();
}

@LazySingleton(as: IWalletDataStorageDatasource)
class WalletDataStorageDatasource implements IWalletDataStorageDatasource {
  late final EncryptedLocalStorage<WalletDataDto> _localWalletDataStorage;

  WalletDataStorageDatasource(
      @Named(walletDataStorage) this._localWalletDataStorage);

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
