// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_get_credentials_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesGetCredentialsResponseDto _$AriesGetCredentialsResponseDtoFromJson(
        Map json) =>
    AriesGetCredentialsResponseDto(
      (json['credentials'] as List<dynamic>)
          .map((e) =>
              AriesCredentialDto.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      json['success'] as bool,
      json['errorMessage'] == null
          ? null
          : NativeErrorDto.fromJson(json['errorMessage'] as Map),
    );

Map<String, dynamic> _$AriesGetCredentialsResponseDtoToJson(
        AriesGetCredentialsResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage?.toJson(),
      'credentials': instance.credentials.map((e) => e.toJson()).toList(),
    };
