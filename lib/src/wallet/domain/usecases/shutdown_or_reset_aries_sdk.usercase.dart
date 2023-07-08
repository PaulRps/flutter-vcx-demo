import 'package:flutter_vcx_demo/src/connections/connections.dart';
import 'package:flutter_vcx_demo/src/credentials/credentials.dart';
import 'package:injectable/injectable.dart';

import '../genesis.repository.dart';
import '../sdk.repository.dart';
import '../wallet.repository.dart';

@Injectable()
class ShutdownOrResetAriesSdkUseCase {
  late final ISdkRepository _ariesSdkRepository;
  late final IGenesisRepository _ariesGenesisRepository;
  late final IWalletRepository _walletDataRepository;
  late final IConnectionRepository _ariesConnectionRepository;
  late final ICredentialRepository _ariesCredentialRepository;

  ShutdownOrResetAriesSdkUseCase(
      this._ariesSdkRepository,
      this._ariesGenesisRepository,
      this._walletDataRepository,
      this._ariesConnectionRepository,
      this._ariesCredentialRepository);

  Future<bool> shutdownSdk() {
    return _ariesSdkRepository.shutdownSdk(deleteWallet: false);
  }

  Future<bool> resetSdk() {
    return _ariesSdkRepository
        .shutdownSdk(deleteWallet: true)
        .then((value) => _ariesGenesisRepository.deleteGenesisFile())
        .then((value) => _walletDataRepository.delete())
        .then((value) => _ariesConnectionRepository.deleteConnectionData())
        .then((value) => _ariesCredentialRepository.deleteCredentialsData());
  }
}
