// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_request_aries_proof_channel.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlutterRequestAriesProofChannelDto _$FlutterRequestAriesProofChannelDtoFromJson(
        Map<String, dynamic> json) =>
    FlutterRequestAriesProofChannelDto(
      pairwiseDid: json['pairwiseDid'],
      sourceId: json['sourceId'],
      proofName: json['proofName'] as String?,
      requestedAttributes: (json['requestedAttributes'] as List<dynamic>?)
          ?.map((e) => AriesRequestedProofAttributeDto.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FlutterRequestAriesProofChannelDtoToJson(
        FlutterRequestAriesProofChannelDto instance) =>
    <String, dynamic>{
      'pairwiseDid': instance.pairwiseDid,
      'sourceId': instance.sourceId,
      'requestedAttributes':
          instance.requestedAttributes?.map((e) => e.toJson()).toList(),
      'proofName': instance.proofName,
    };
