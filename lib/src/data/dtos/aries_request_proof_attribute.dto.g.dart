// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_request_proof_attribute.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesRequestedProofAttributeDto _$AriesRequestedProofAttributeDtoFromJson(
        Map<String, dynamic> json) =>
    AriesRequestedProofAttributeDto(
      name: json['name'] as String,
      schemaName: json['schemaName'] as String,
      schemaVersion: json['schemaVersion'] as String,
    );

Map<String, dynamic> _$AriesRequestedProofAttributeDtoToJson(
        AriesRequestedProofAttributeDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'schemaName': instance.schemaName,
      'schemaVersion': instance.schemaVersion,
    };
