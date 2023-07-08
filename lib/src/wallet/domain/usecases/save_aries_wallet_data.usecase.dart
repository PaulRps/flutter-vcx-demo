import 'package:injectable/injectable.dart';

import '../entities/entities.dart';
import '../wallet.repository.dart';

@Injectable()
class SaveAriesWalletDataUseCase {
  late final IWalletRepository _walletDataRepository;

  SaveAriesWalletDataUseCase(this._walletDataRepository);

  Future<void> save(WalletData data) {
    return _walletDataRepository.save(data);
  }
}
