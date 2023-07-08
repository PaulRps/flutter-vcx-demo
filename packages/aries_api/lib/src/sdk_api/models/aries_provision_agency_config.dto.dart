import 'package:json_annotation/json_annotation.dart';

part 'aries_provision_agency_config.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AriesProvisionAgencyConfigDto {
  String agencyEndpoint;
  String agencyDid;
  String agencyVerkey;
  String? institutionName;

  AriesProvisionAgencyConfigDto(this.agencyEndpoint, this.agencyDid,
      this.agencyVerkey, this.institutionName);

  AriesProvisionAgencyConfigDto.from(this.agencyEndpoint)
      : agencyDid = const String.fromEnvironment("mediator_did"),
        agencyVerkey = const String.fromEnvironment("mediator_verkey"),
        institutionName = const String.fromEnvironment("institution_name");

  factory AriesProvisionAgencyConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AriesProvisionAgencyConfigDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesProvisionAgencyConfigDtoToJson(this);
}
