import 'package:flutter_vcx_demo/src/data/repositories/aries_genesis.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_sdk.repository.dart';
import 'package:flutter_vcx_demo/src/domain/entities/wallet_data.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/save_aries_wallet_data.usecase.dart';
import 'package:injectable/injectable.dart';

import '../../data/dtos/flutter_request_aries_sdk_channel.dto.dart';

@Injectable()
class StartAriesSdkAndSaveWalletDataUseCase {
  late final IAriesSdkRepository _ariesSdkRepository;
  late final IAriesGenesisRepository _ariesGenesisRepository;
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
        .then((genesisPath) => FlutterRequestAriesSdkChannelDto.from(
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
