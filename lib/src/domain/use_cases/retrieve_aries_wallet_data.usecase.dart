import 'package:flutter_vcx_demo/src/data/repositories/wallet_data.repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/wallet_data.dart';

@Injectable()
class RetrieveAriesWalletDataUseCase {
  late final IWalletDataRepository _walletDataRepository;

  RetrieveAriesWalletDataUseCase(this._walletDataRepository);

  Future<WalletData> retrieveWalletData() {
    return _walletDataRepository.get();
  }
}
