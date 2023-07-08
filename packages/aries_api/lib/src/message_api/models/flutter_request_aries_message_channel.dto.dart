import 'package:aries_api/src/message_api/models/aries_agency_message_status.enum.dart';
import 'package:json_annotation/json_annotation.dart';


part 'flutter_request_aries_message_channel.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FlutterRequestAriesMessageChannelDto {
  String msgUuid;
  AriesAgencyMessageStatusEnum msgStatus;
  String pairwiseDid;

  FlutterRequestAriesMessageChannelDto(
      this.msgUuid, this.msgStatus, this.pairwiseDid);

  factory FlutterRequestAriesMessageChannelDto.from(
          {msgUuid, msgStatus, pairwiseDid}) =>
      FlutterRequestAriesMessageChannelDto(msgUuid, msgStatus, pairwiseDid);

  factory FlutterRequestAriesMessageChannelDto.fromJson(
          Map<String, dynamic> json) =>
      _$FlutterRequestAriesMessageChannelDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FlutterRequestAriesMessageChannelDtoToJson(this);
}
