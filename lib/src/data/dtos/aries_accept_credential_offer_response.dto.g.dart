// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_accept_credential_offer_response.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesAcceptCredentialOfferResponseDto
    _$AriesAcceptCredentialOfferResponseDtoFromJson(Map json) =>
        AriesAcceptCredentialOfferResponseDto(
          json['credentialName'] as String,
          json['success'] as bool,
          errorMessage: json['errorMessage'],
        );

Map<String, dynamic> _$AriesAcceptCredentialOfferResponseDtoToJson(
        AriesAcceptCredentialOfferResponseDto instance) =>
    <String, dynamic>{
      'success': instance.success,
      'errorMessage': instance.errorMessage,
      'credentialName': instance.credentialName,
    };
