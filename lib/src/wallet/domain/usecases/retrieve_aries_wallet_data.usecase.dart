import 'package:injectable/injectable.dart';

import '../entities/entities.dart';
import '../wallet.repository.dart';

@Injectable()
class RetrieveAriesWalletDataUseCase {
  late final IWalletRepository _walletDataRepository;

  RetrieveAriesWalletDataUseCase(this._walletDataRepository);

  Future<WalletData> retrieveWalletData() {
    return _walletDataRepository.get();
  }
}
