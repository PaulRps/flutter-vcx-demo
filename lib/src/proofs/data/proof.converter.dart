import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/proofs/domain/domain.dart';
import 'package:smartstruct/smartstruct.dart';
import 'package:injectable/injectable.dart';

part 'proof.converter.mapper.g.dart';

@Mapper(useInjection: true)
abstract class ProofConverter {
  @IgnoreMapping()
  AriesSendProofResponseDto toAriesSendProofResponseDto(
          Map<dynamic, dynamic> json) =>
      AriesSendProofResponseDto.fromJson(json);

  ProofRequestedData toProofRequestData(AriesSendProofResponseDto from);

  AriesRequestedProofAttributeDto toAriesRequestedProofAttributeDto(
      RequestedAttribute from);

  @IgnoreMapping()
  List<AriesRequestedProofAttributeDto> toAriesRequestedProofAttributeDtoList(
          List<RequestedAttribute> from) =>
      from.map((e) => toAriesRequestedProofAttributeDto(e)).toList();
}
