import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_sdk_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_credential.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_sdk.repository.dart';

import '../../data/datasources/wallet_data_storage.datasource.dart';
import '../../data/repositories/aries_genesis.repository.dart';
import '../../data/repositories/wallet_data.repository.dart';
import '../../data/services/wallet_data_encrypted_local_storage.dart';

class ShutdownOrResetAriesSdkUsecase {
  late final AriesSdkRepository _ariesSdkRepository;
  late final IAriesGenesisRepository _ariesGenesisRepository;
  late final IWalletDataRepository _walletDataRepository;
  late final IAriesConnectionRepository _ariesConnectionRepository;
  late final IAriesCredentialRepository _ariesCredentialRepository;

  ShutdownOrResetAriesSdkUsecase(
      {ariesSdkRepository,
      ariesGenesisRepository,
      walletDataRepository,
      ariesConnectionRepository,
      ariesCredentialRepository})
      : _ariesSdkRepository = ariesSdkRepository ?? AriesSdkRepository(),
        _ariesGenesisRepository =
            ariesGenesisRepository ?? AriesGenesisRepository(),
        _walletDataRepository = walletDataRepository ??
            WalletDataRepository(
                WalletDataStorageDatasource(WalletDataEncryptedLocaStorage())),
        _ariesConnectionRepository =
            ariesConnectionRepository ?? AriesConnectionRepository(),
        _ariesCredentialRepository =
            ariesCredentialRepository ?? AriesCredentialRepository();

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
