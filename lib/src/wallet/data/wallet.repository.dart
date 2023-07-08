import 'package:flutter_vcx_demo/src/wallet/data/wallet_data_storage.datasource.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IWalletRepository)
class WalletRepository implements IWalletRepository {
  late final IWalletDataStorageDatasource _walletDataStorageDatasource;

  WalletRepository(this._walletDataStorageDatasource);

  @override
  Future<WalletData> get() {
    return _walletDataStorageDatasource.get().then(
        (value) => WalletData(name: value?.name ?? "", key: value?.key ?? ""));
  }

  @override
  Future<void> save(WalletData data) {
    return _walletDataStorageDatasource.save(data);
  }

  @override
  Future<bool> delete() {
    return _walletDataStorageDatasource.delete();
  }
}
