// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_request_aries_connection_channel.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlutterRequestAriesConnectionChannelDto
    _$FlutterRequestAriesConnectionChannelDtoFromJson(
            Map<String, dynamic> json) =>
        FlutterRequestAriesConnectionChannelDto(
          sourceId: json['sourceId'] as String?,
          invitation: json['invitation'] == null
              ? null
              : AriesConnectionInvitationDto.fromJson(
                  json['invitation'] as Map<String, dynamic>),
          connectionHandle: json['connectionHandle'] as String?,
          isToDeleteHandle: json['isToDeleteHandle'] as bool?,
        );

Map<String, dynamic> _$FlutterRequestAriesConnectionChannelDtoToJson(
        FlutterRequestAriesConnectionChannelDto instance) =>
    <String, dynamic>{
      'sourceId': instance.sourceId,
      'invitation': instance.invitation?.toJson(),
      'connectionHandle': instance.connectionHandle,
      'isToDeleteHandle': instance.isToDeleteHandle,
    };
