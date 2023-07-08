import 'package:json_annotation/json_annotation.dart';

part 'flutter_request_aries_credential_channel.dto.g.dart';

@JsonSerializable()
class FlutterRequestAriesCredentialChannelDto {
  String? pairwiseDid;
  String? sourceId;

  FlutterRequestAriesCredentialChannelDto({this.pairwiseDid, this.sourceId});

  factory FlutterRequestAriesCredentialChannelDto.fromJson(Map<String, dynamic> json) =>
      _$FlutterRequestAriesCredentialChannelDtoFromJson(json);

  Map<String, dynamic> toJson() => _$FlutterRequestAriesCredentialChannelDtoToJson(this);
}