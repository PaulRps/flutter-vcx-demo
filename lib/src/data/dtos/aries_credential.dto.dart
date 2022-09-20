import 'package:json_annotation/json_annotation.dart';

part 'aries_credential.dto.g.dart';

@JsonSerializable()
class AriesCredentialDto {
  static const String CREDENTIAL_REF = "credential_data_ref";

  String name;

  AriesCredentialDto(this.name);

  factory AriesCredentialDto.fromJson(Map<String, dynamic> json) =>
      _$AriesCredentialDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesCredentialDtoToJson(this);
}
