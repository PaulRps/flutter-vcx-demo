// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_sdk_start_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesSdkStartResponse _$AriesSdkStartResponseFromJson(Map json) =>
    AriesSdkStartResponse(
      json['success'] as bool,
      errorMessage: json['errorMessage'],
      agentDid: json['agentDid'],
    );

Map<String, dynamic> _$AriesSdkStartResponseToJson(
        AriesSdkStartResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage?.toJson(),
      'agentDid': instance.agentDid,
    };
