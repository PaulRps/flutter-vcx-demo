import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_sdk_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_credential.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_sdk.repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/aries_genesis.repository.dart';
import '../../data/repositories/wallet_data.repository.dart';

@Injectable()
class ShutdownOrResetAriesSdkUseCase {
  late final IAriesSdkRepository _ariesSdkRepository;
  late final IAriesGenesisRepository _ariesGenesisRepository;
  late final IWalletDataRepository _walletDataRepository;
  late final IAriesConnectionRepository _ariesConnectionRepository;
  late final IAriesCredentialRepository _ariesCredentialRepository;

  ShutdownOrResetAriesSdkUseCase(
      this._ariesSdkRepository,
      this._ariesGenesisRepository,
      this._walletDataRepository,
      this._ariesConnectionRepository,
      this._ariesCredentialRepository);

  Future<bool> shutdownSdk() {
    var dto = FlutterRequestAriesSdkChannelDto(null, false);
    return _ariesSdkRepository.shutdownSdk(dto);
  }

  Future<bool> resetSdk() {
    var dto = FlutterRequestAriesSdkChannelDto(null, true);
    return _ariesSdkRepository
        .shutdownSdk(dto)
        .then((value) => _ariesGenesisRepository.deleteGenesisFile())
        .then((value) => _walletDataRepository.delete())
        .then((value) => _ariesConnectionRepository.deleteConnectionData())
        .then((value) => _ariesCredentialRepository.deleteCredentialsData());
  }
}
