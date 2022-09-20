// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_local_wallet_config.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesLocalWalletConfigDto _$AriesLocalWalletConfigDtoFromJson(
        Map<String, dynamic> json) =>
    AriesLocalWalletConfigDto(
      json['walletName'] as String?,
      json['walletKey'] as String?,
      $enumDecodeNullable(
          _$WalletKeyDerivationEnumEnumMap, json['walletKeyDerivation']),
    );

Map<String, dynamic> _$AriesLocalWalletConfigDtoToJson(
        AriesLocalWalletConfigDto instance) =>
    <String, dynamic>{
      'walletName': instance.walletName,
      'walletKey': instance.walletKey,
      'walletKeyDerivation':
          _$WalletKeyDerivationEnumEnumMap[instance.walletKeyDerivation],
    };

const _$WalletKeyDerivationEnumEnumMap = {
  WalletKeyDerivationEnum.raw: 'raw',
  WalletKeyDerivationEnum.argon2i_mod: 'argon2i_mod',
};
