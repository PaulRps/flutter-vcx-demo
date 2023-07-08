import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'aries_connection_invitation.dto.g.dart';

@JsonSerializable()
class AriesConnectionInvitationDto {
  @JsonKey(name: "@id")
  final String id;
  @JsonKey(name: "@type")
  final String type;
  final String label;
  final String? imageUrl;
  // ignore: non_constant_identifier_names
  final String? image_url;
  final String serviceEndpoint;
  final List<String> recipientKeys;
  final List<String?>? routingKeys;

  AriesConnectionInvitationDto(
      {required this.id,
        required this.type,
        required this.label,
        this.imageUrl,
        required this.serviceEndpoint,
        required this.recipientKeys,
        this.routingKeys,
        // ignore: non_constant_identifier_names
        this.image_url});

  factory AriesConnectionInvitationDto.fromBase64(String base64) {
    dynamic json = utf8.fuse(base64Url).decode(base64);
    return AriesConnectionInvitationDto.fromJson(jsonDecode(json));
  }

  factory AriesConnectionInvitationDto.fromJson(
      Map<String, dynamic> json) =>
      _$AriesConnectionInvitationDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AriesConnectionInvitationDtoToJson(this);
}