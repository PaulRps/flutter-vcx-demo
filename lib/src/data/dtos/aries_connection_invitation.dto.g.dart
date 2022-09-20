// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_connection_invitation.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesConnectionInvitationDto _$AriesConnectionInvitationDtoFromJson(
        Map<String, dynamic> json) =>
    AriesConnectionInvitationDto(
      id: json['@id'] as String,
      type: json['@type'] as String,
      label: json['label'] as String,
      imageUrl: json['imageUrl'] as String?,
      serviceEndpoint: json['serviceEndpoint'] as String,
      recipientKeys: (json['recipientKeys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      routingKeys: (json['routingKeys'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      image_url: json['image_url'] as String?,
    );

Map<String, dynamic> _$AriesConnectionInvitationDtoToJson(
        AriesConnectionInvitationDto instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'label': instance.label,
      'imageUrl': instance.imageUrl,
      'image_url': instance.image_url,
      'serviceEndpoint': instance.serviceEndpoint,
      'recipientKeys': instance.recipientKeys,
      'routingKeys': instance.routingKeys,
    };
