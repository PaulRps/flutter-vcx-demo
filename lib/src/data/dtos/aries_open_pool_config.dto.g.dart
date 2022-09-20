// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_open_pool_config.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesOpenPoolConfigDto _$AriesOpenPoolConfigDtoFromJson(
        Map<String, dynamic> json) =>
    AriesOpenPoolConfigDto(
      json['genesisPath'] as String?,
      json['poolName'] as String?,
      json['poolConfig'] as String?,
    );

Map<String, dynamic> _$AriesOpenPoolConfigDtoToJson(
        AriesOpenPoolConfigDto instance) =>
    <String, dynamic>{
      'genesisPath': instance.genesisPath,
      'poolName': instance.poolName,
      'poolConfig': instance.poolConfig,
    };
