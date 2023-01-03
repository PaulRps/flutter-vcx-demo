import 'package:flutter_vcx_demo/src/data/datasources/wallet_data_storage.datasource.dart';
import 'package:flutter_vcx_demo/src/data/dtos/wallet_data.dto.dart';
import 'package:flutter_vcx_demo/src/domain/entities/wallet_data.dart';
import 'package:injectable/injectable.dart';

abstract class IWalletDataRepository {
  Future<void> save(WalletData data);

  Future<WalletData> get();

  Future<bool> delete();
}

@LazySingleton(as: IWalletDataRepository)
class WalletDataRepository implements IWalletDataRepository {
  late final IWalletDataStorageDatasource _walletDataStorageDatasource;

  WalletDataRepository(this._walletDataStorageDatasource);

  @override
  Future<WalletData> get() {
    return _walletDataStorageDatasource.get().then(
        (value) => WalletData(name: value?.name ?? "", key: value?.key ?? ""));
  }

  @override
  Future<void> save(WalletData data) {
    return _walletDataStorageDatasource
        .save(WalletDataDto(data.name, data.key));
  }

  @override
  Future<bool> delete() {
    return _walletDataStorageDatasource.delete();
  }
}
