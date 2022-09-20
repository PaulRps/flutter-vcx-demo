// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_sdk_config.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesSdkConfigDto _$AriesSdkConfigDtoFromJson(Map<String, dynamic> json) =>
    AriesSdkConfigDto(
      AriesProvisionAgencyConfigDto.fromJson(
          json['provisionConfig'] as Map<String, dynamic>),
      json['initThreadPoolConfig'] == null
          ? null
          : AriesInitThreadPoolConfigDto.fromJson(
              json['initThreadPoolConfig'] as Map<String, dynamic>),
      json['openMainPoolConfig'] == null
          ? null
          : AriesOpenPoolConfigDto.fromJson(
              json['openMainPoolConfig'] as Map<String, dynamic>),
      json['localWalletConfig'] == null
          ? null
          : AriesLocalWalletConfigDto.fromJson(
              json['localWalletConfig'] as Map<String, dynamic>),
    )..logLevel =
        $enumDecodeNullable(_$AriesSdkLogLevelEnumEnumMap, json['logLevel']);

Map<String, dynamic> _$AriesSdkConfigDtoToJson(AriesSdkConfigDto instance) =>
    <String, dynamic>{
      'provisionConfig': instance.provisionConfig.toJson(),
      'initThreadPoolConfig': instance.initThreadPoolConfig?.toJson(),
      'openMainPoolConfig': instance.openMainPoolConfig?.toJson(),
      'localWalletConfig': instance.localWalletConfig?.toJson(),
      'logLevel': _$AriesSdkLogLevelEnumEnumMap[instance.logLevel],
    };

const _$AriesSdkLogLevelEnumEnumMap = {
  AriesSdkLogLevelEnum.debug: 'debug',
  AriesSdkLogLevelEnum.info: 'info',
  AriesSdkLogLevelEnum.trace: 'trace',
};
