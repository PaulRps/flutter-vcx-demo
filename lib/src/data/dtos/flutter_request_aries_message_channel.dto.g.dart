// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_request_aries_message_channel.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlutterRequestAriesMessageChannelDto
    _$FlutterRequestAriesMessageChannelDtoFromJson(Map<String, dynamic> json) =>
        FlutterRequestAriesMessageChannelDto(
          json['msgUuid'] as String,
          $enumDecode(_$AriesAgencyMessageStatusEnumEnumMap, json['msgStatus']),
          json['pairwiseDid'] as String,
        );

Map<String, dynamic> _$FlutterRequestAriesMessageChannelDtoToJson(
        FlutterRequestAriesMessageChannelDto instance) =>
    <String, dynamic>{
      'msgUuid': instance.msgUuid,
      'msgStatus': _$AriesAgencyMessageStatusEnumEnumMap[instance.msgStatus]!,
      'pairwiseDid': instance.pairwiseDid,
    };

const _$AriesAgencyMessageStatusEnumEnumMap = {
  AriesAgencyMessageStatusEnum.none: 'none',
  AriesAgencyMessageStatusEnum.created: 'created',
  AriesAgencyMessageStatusEnum.sent: 'sent',
  AriesAgencyMessageStatusEnum.received: 'received',
  AriesAgencyMessageStatusEnum.accepted: 'accepted',
  AriesAgencyMessageStatusEnum.rejected: 'rejected',
  AriesAgencyMessageStatusEnum.reviewed: 'reviewed',
};
