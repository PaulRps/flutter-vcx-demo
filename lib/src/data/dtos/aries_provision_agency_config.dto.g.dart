// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aries_provision_agency_config.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AriesProvisionAgencyConfigDto _$AriesProvisionAgencyConfigDtoFromJson(
        Map<String, dynamic> json) =>
    AriesProvisionAgencyConfigDto(
      json['agencyEndpoint'] as String,
      json['agencyDid'] as String,
      json['agencyVerkey'] as String,
      json['institutionName'] as String?,
    );

Map<String, dynamic> _$AriesProvisionAgencyConfigDtoToJson(
        AriesProvisionAgencyConfigDto instance) =>
    <String, dynamic>{
      'agencyEndpoint': instance.agencyEndpoint,
      'agencyDid': instance.agencyDid,
      'agencyVerkey': instance.agencyVerkey,
      'institutionName': instance.institutionName,
    };
