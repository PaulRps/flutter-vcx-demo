import 'package:flutter_vcx_demo/src/data/dtos/aries_connection_invitation.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flutter_request_aries_connection_channel.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FlutterRequestAriesConnectionChannelDto {
  String? inviteId;
  AriesConnectionInvitationDto? invitation;
  String? connectionHandle;
  bool? isToDeleteHandle;

  FlutterRequestAriesConnectionChannelDto(
      {this.inviteId, this.invitation, this.connectionHandle, this.isToDeleteHandle});

  factory FlutterRequestAriesConnectionChannelDto.fromJson(
          Map<String, dynamic> json) =>
      _$FlutterRequestAriesConnectionChannelDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FlutterRequestAriesConnectionChannelDtoToJson(this);
}
