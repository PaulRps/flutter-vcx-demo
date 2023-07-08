import 'package:flutter_vcx_demo/src/wallet/domain/entities/sdk_settings.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/entities/wallet_data.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/usecases/save_aries_wallet_data.usecase.dart';
import 'package:injectable/injectable.dart';

import '../genesis.repository.dart';
import '../sdk.repository.dart';

@Injectable()
class StartAriesSdkAndSaveWalletDataUseCase {
  late final ISdkRepository _ariesSdkRepository;
  late final IGenesisRepository _ariesGenesisRepository;
  late final SaveAriesWalletDataUseCase _saveWalletDataUseCase;

  StartAriesSdkAndSaveWalletDataUseCase(this._ariesSdkRepository,
      this._ariesGenesisRepository, this._saveWalletDataUseCase);

  Future<bool> startSdkAndSaveWalletData(WalletData data) {
    if (data.key.isEmpty) {
      return Future.error("Wallet key is required!");
    }

    if (data.name.isEmpty) {
      return Future.error("Wallet name is required!");
    }

    return _ariesGenesisRepository
        .getGenesisFilePath()
        .then((genesisPath) => SdkSettings(
            agencyEndpoint: const String.fromEnvironment("mediator_url"),
            genesisPath: genesisPath,
            walletName: data.name.trim(),
            walletKey: data.key.trim()))
        .then((dto) => _ariesSdkRepository.startSdk(dto))
        .then((response) {
      return _saveWalletDataUseCase.save(data).then((value) => response);
    });
  }
}
