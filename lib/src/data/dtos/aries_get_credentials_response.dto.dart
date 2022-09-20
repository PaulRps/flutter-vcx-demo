import 'package:flutter_vcx_demo/src/data/dtos/aries_credential.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/native_to_flutter_response.dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'native_error.dto.dart';

part 'aries_get_credentials_response.dto.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class AriesGetCredentialsResponseDto extends NativeToFlutterResponseDto {
  List<AriesCredentialDto> credentials;

  AriesGetCredentialsResponseDto(
      this.credentials, bool success, NativeErrorDto? errorMessage)
      : super(success, errorMessage: errorMessage);

  factory AriesGetCredentialsResponseDto.fromJson(Map json) =>
      _$AriesGetCredentialsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesGetCredentialsResponseDtoToJson(this);
}
