import 'package:flutter_vcx_demo/src/core/data/local_storage.service.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'wallet_data_encrypted_local_storage.dart';

abstract class IWalletDataStorageDatasource {
  Future<void> save(WalletData data);

  Future<WalletData?> get();

  Future<bool> delete();
}

@LazySingleton(as: IWalletDataStorageDatasource)
class WalletDataStorageDatasource implements IWalletDataStorageDatasource {
  late final EncryptedLocalStorage<WalletData> _localWalletDataStorage;

  WalletDataStorageDatasource(
      @Named(walletDataStorage) this._localWalletDataStorage);

  @override
  Future<void> save(WalletData data) {
    return _localWalletDataStorage.save(data);
  }

  @override
  Future<WalletData?> get() {
    return _localWalletDataStorage.get();
  }

  @override
  Future<bool> delete() {
    return _localWalletDataStorage.delete();
  }
}
