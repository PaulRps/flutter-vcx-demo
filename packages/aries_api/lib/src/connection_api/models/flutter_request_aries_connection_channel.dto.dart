import 'package:json_annotation/json_annotation.dart';

import 'aries_connection_invitation.dto.dart';

part 'flutter_request_aries_connection_channel.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FlutterRequestAriesConnectionChannelDto {
  String? sourceId;
  AriesConnectionInvitationDto? invitation;
  String? connectionHandle;
  bool? isToDeleteHandle;

  FlutterRequestAriesConnectionChannelDto(
      {this.sourceId, this.invitation, this.connectionHandle, this.isToDeleteHandle});

  factory FlutterRequestAriesConnectionChannelDto.fromJson(
          Map<String, dynamic> json) =>
      _$FlutterRequestAriesConnectionChannelDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FlutterRequestAriesConnectionChannelDtoToJson(this);
}
