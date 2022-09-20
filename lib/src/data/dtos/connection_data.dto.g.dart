// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_data.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConnectionDataDto _$ConnectionDataDtoFromJson(Map<String, dynamic> json) =>
    ConnectionDataDto(
      json['pairwiseDto'] as String?,
      json['connectionName'] as String?,
    );

Map<String, dynamic> _$ConnectionDataDtoToJson(ConnectionDataDto instance) =>
    <String, dynamic>{
      'pairwiseDto': instance.pairwiseDto,
      'connectionName': instance.connectionName,
    };
