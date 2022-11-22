import 'package:flutter_vcx_demo/src/data/dtos/aries_request_proof_attribute.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_credential_channel.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flutter_request_aries_proof_channel.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FlutterRequestAriesProofChannelDto
    extends FlutterRequestAriesCredentialChannelDto {
  List<AriesRequestedProofAttributeDto>? requestedAttributes;
  String? proofName;

  FlutterRequestAriesProofChannelDto(
      {pairwiseDid, sourceId, this.proofName, this.requestedAttributes})
      : super(pairwiseDid: pairwiseDid, sourceId: sourceId);

  factory FlutterRequestAriesProofChannelDto.fromJson(
          Map<String, dynamic> json) =>
      _$FlutterRequestAriesProofChannelDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FlutterRequestAriesProofChannelDtoToJson(this);
}
