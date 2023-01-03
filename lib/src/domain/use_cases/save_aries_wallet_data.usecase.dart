import 'package:flutter_vcx_demo/src/domain/entities/wallet_data.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/wallet_data.repository.dart';

@Injectable()
class SaveAriesWalletDataUseCase {
  late final IWalletDataRepository _walletDataRepository;

  SaveAriesWalletDataUseCase(this._walletDataRepository);

  Future<void> save(WalletData data) {
    return _walletDataRepository.save(data);
  }
}
