import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aries_send_proof_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AriesSendProofResponseDto extends NativeToFlutterResponseDto {
  final Map<String, dynamic>? revealedAttributes;
  final Map<String, dynamic>? selfAttestAttributes;

  AriesSendProofResponseDto(
      {required success,
      errorMessage,
      this.revealedAttributes,
      this.selfAttestAttributes})
      : super(success, errorMessage: errorMessage);

  factory AriesSendProofResponseDto.fromJson(Map json) =>
      _$AriesSendProofResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesSendProofResponseDtoToJson(this);
}
