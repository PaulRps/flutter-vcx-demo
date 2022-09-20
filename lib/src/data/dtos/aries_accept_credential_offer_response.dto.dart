import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'aries_accept_credential_offer_response.dto.g.dart';

@JsonSerializable(anyMap: true)
class AriesAcceptCredentialOfferResponseDto extends NativeToFlutterResponseDto {
  String credentialName;

  AriesAcceptCredentialOfferResponseDto(this.credentialName, bool success,
      {errorMessage})
      : super(success, errorMessage: errorMessage);

  factory AriesAcceptCredentialOfferResponseDto.fromJson(Map json) =>
      _$AriesAcceptCredentialOfferResponseDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AriesAcceptCredentialOfferResponseDtoToJson(this);
}
