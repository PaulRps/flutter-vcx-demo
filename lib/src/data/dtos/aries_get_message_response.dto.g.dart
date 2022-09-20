// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_get_message_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesGetMessageResponseDto _$AriesGetMessageResponseDtoFromJson(Map json) =>
    AriesGetMessageResponseDto(
      json['msg'] as String?,
      json['pairwiseDid'] as String?,
      json['success'] as bool,
      json['errorMessage'] == null
          ? null
          : NativeErrorDto.fromJson(json['errorMessage'] as Map),
    );

Map<String, dynamic> _$AriesGetMessageResponseDtoToJson(
        AriesGetMessageResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage?.toJson(),
      'msg': instance.msg,
      'pairwiseDid': instance.pairwiseDid,
    };
