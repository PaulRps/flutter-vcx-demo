// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_create_connection_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesCreateConnectionResponseDto _$AriesCreateConnectionResponseDtoFromJson(
        Map json) =>
    AriesCreateConnectionResponseDto(
      json['pairwiseDid'] as String?,
      json['connectionName'] as String?,
      json['success'] as bool,
      json['errorMessage'] == null
          ? null
          : NativeErrorDto.fromJson(json['errorMessage'] as Map),
    );

Map<String, dynamic> _$AriesCreateConnectionResponseDtoToJson(
        AriesCreateConnectionResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage?.toJson(),
      'pairwiseDid': instance.pairwiseDid,
      'connectionName': instance.connectionName,
    };
