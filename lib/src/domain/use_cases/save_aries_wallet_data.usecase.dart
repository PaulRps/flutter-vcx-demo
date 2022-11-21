import 'package:flutter_vcx_demo/src/domain/entities/wallet_data.dart';

import '../../data/datasources/wallet_data_storage.datasource.dart';
import '../../data/repositories/wallet_data.repository.dart';
import '../../data/services/wallet_data_encrypted_local_storage.dart';

class SaveAriesWalletDataUseCase {
  late final IWalletDataRepository _walletDataRepository;

  SaveAriesWalletDataUseCase({walletDataRepository})
      : _walletDataRepository = walletDataRepository ??
            WalletDataRepository(
                WalletDataStorageDatasource(WalletDataEncryptedLocaStorage()));

  Future<void> save(WalletData data) {
    return _walletDataRepository.save(data);
  }
}
