// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_send_proof_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesSendProofResponseDto _$AriesSendProofResponseDtoFromJson(Map json) =>
    AriesSendProofResponseDto(
      success: json['success'],
      errorMessage: json['errorMessage'],
      revealedAttributes: (json['revealedAttributes'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e),
      ),
      selfAttestAttributes: (json['selfAttestAttributes'] as Map?)?.map(
        (k, e) => MapEntry(k as String, e),
      ),
    );

Map<String, dynamic> _$AriesSendProofResponseDtoToJson(
        AriesSendProofResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage?.toJson(),
      'revealedAttributes': instance.revealedAttributes,
      'selfAttestAttributes': instance.selfAttestAttributes,
    };
