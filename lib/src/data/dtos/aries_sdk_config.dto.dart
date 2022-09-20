import 'package:flutter_vcx_demo/src/data/dtos/aries_local_wallet_config.dto.dart';
import 'package:flutter_vcx_demo/src/data/enums/aries_sdk_log_level.enum.dart';
import 'package:flutter_vcx_demo/src/data/enums/wallet_key_derivation.enum.dart';
import 'package:json_annotation/json_annotation.dart';

import 'aries_provision_agency_config.dto.dart';
import 'aries_init_thread_pool_config.dto.dart';
import 'aries_open_pool_config.dto.dart';

part 'aries_sdk_config.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AriesSdkConfigDto {
  AriesProvisionAgencyConfigDto provisionConfig;
  AriesInitThreadPoolConfigDto? initThreadPoolConfig;
  AriesOpenPoolConfigDto? openMainPoolConfig;
  AriesLocalWalletConfigDto? localWalletConfig;
  AriesSdkLogLevelEnum? logLevel;

  AriesSdkConfigDto(this.provisionConfig, this.initThreadPoolConfig,
      this.openMainPoolConfig, this.localWalletConfig);

  AriesSdkConfigDto.from(String agencyEndpoint, String genesisPath,
      String walletName, String walletKey,
      {walletKeyDerivation = WalletKeyDerivationEnum.argon2i_mod,
      logLevel = AriesSdkLogLevelEnum.trace})
      : provisionConfig = AriesProvisionAgencyConfigDto.from(agencyEndpoint),
        initThreadPoolConfig = AriesInitThreadPoolConfigDto(),
        openMainPoolConfig = AriesOpenPoolConfigDto.from(genesisPath),
        localWalletConfig = AriesLocalWalletConfigDto(
            walletName, walletKey, walletKeyDerivation),
        logLevel = logLevel;

  factory AriesSdkConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AriesSdkConfigDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesSdkConfigDtoToJson(this);
}
