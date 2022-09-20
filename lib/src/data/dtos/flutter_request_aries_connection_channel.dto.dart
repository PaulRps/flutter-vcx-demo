import 'package:flutter_vcx_demo/src/data/dtos/aries_connection_invitation.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flutter_request_aries_connection_channel.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FlutterRequestAriesConnectionChannelDto {
  String? inviteId;
  AriesConnectionInvitationDto? invitation;

  FlutterRequestAriesConnectionChannelDto({inviteId, invitation})
      : inviteId = inviteId,
        invitation = invitation;

  factory FlutterRequestAriesConnectionChannelDto.fromJson(Map<String, dynamic> json) =>
      _$FlutterRequestAriesConnectionChannelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FlutterRequestAriesConnectionChannelDtoToJson(this);
}
