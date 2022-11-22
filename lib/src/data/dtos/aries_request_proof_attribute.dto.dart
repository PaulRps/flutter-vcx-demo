import 'package:json_annotation/json_annotation.dart';

part 'aries_request_proof_attribute.dto.g.dart';

@JsonSerializable()
class AriesRequestedProofAttributeDto {
  String name;
  String schemaName;
  String schemaVersion;

  AriesRequestedProofAttributeDto(
      {required this.name,
      required this.schemaName,
      required this.schemaVersion});

  factory AriesRequestedProofAttributeDto.fromJson(Map<String, dynamic> json) =>
      _$AriesRequestedProofAttributeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesRequestedProofAttributeDtoToJson(this);
}
