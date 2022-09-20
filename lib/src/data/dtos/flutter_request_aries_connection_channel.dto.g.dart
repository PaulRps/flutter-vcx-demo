// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_request_aries_connection_channel.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlutterRequestAriesConnectionChannelDto
    _$FlutterRequestAriesConnectionChannelDtoFromJson(
            Map<String, dynamic> json) =>
        FlutterRequestAriesConnectionChannelDto(
          inviteId: json['inviteId'],
          invitation: json['invitation'],
        );

Map<String, dynamic> _$FlutterRequestAriesConnectionChannelDtoToJson(
        FlutterRequestAriesConnectionChannelDto instance) =>
    <String, dynamic>{
      'inviteId': instance.inviteId,
      'invitation': instance.invitation?.toJson(),
    };
