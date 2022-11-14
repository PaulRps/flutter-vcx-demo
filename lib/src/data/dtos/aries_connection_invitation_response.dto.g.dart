// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_connection_invitation_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesConnectionInvitationResponseDto
    _$AriesConnectionInvitationResponseDtoFromJson(Map json) =>
        AriesConnectionInvitationResponseDto(
          json['invitation'] as String?,
          json['connectionHandle'] as String?,
          json['success'] as bool,
          json['errorMessage'] == null
              ? null
              : NativeErrorDto.fromJson(json['errorMessage'] as Map),
        );

Map<String, dynamic> _$AriesConnectionInvitationResponseDtoToJson(
        AriesConnectionInvitationResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage?.toJson(),
      'invitation': instance.invitation,
      'connectionHandle': instance.connectionHandle,
    };
