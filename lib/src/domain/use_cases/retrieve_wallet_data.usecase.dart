import 'package:flutter_vcx_demo/src/data/repositories/wallet_data.repository.dart';

import '../../data/datasources/wallet_data_storage.datasource.dart';
import '../../data/services/wallet_data_encrypted_local_storage.dart';
import '../entities/wallet_data.dart';

class RetrieveWalletDataUseCase {
  late final IWalletDataRepository _walletDataRepository;

  RetrieveWalletDataUseCase({walletDataRepository})
      : _walletDataRepository = walletDataRepository ??
            WalletDataRepository(
                WalletDataStorageDatasource(WalletDataEncryptedLocaStorage()));

  Future<WalletData> retrieveWalletData() {
    return _walletDataRepository.get();
  }
}
