import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/proofs/data/aries_proof.datasource.dart';
import 'package:injectable/injectable.dart';

import '../domain/domain.dart';
import 'proof.converter.dart';

@LazySingleton(as: IAriesProofRepository)
class AriesProofRepository implements IAriesProofRepository {
  late final IAriesProofDatasource _ariesProofDatasource;
  late final ProofConverter _converter;

  AriesProofRepository(this._ariesProofDatasource, this._converter);

  @override
  Future<bool> presentProof(
      {required String pairwiseDid, required String sourceId}) {
    return _ariesProofDatasource
        .presentProof(FlutterRequestAriesProofChannelDto(
            pairwiseDid: pairwiseDid, sourceId: sourceId))
        .then((value) => true)
        .catchError((error) => false);
  }

  @override
  Future<bool> rejectProof(
      {required String pairwiseDid, required String sourceId}) {
    return _ariesProofDatasource
        .rejectProof(FlutterRequestAriesProofChannelDto(
            pairwiseDid: pairwiseDid, sourceId: sourceId))
        .then((value) => true)
        .catchError((error) => false);
  }

  @override
  Future<ProofRequestedData> sendProofRequest(ProofRequest dto) {
    return _ariesProofDatasource
        .sendProofRequest(FlutterRequestAriesProofChannelDto(
            proofName: dto.proofName,
            requestedAttributes:
                _converter.toAriesRequestedProofAttributeDtoList(
                    dto.requestedAttributes!)))
        .then((value) => _converter
            .toProofRequestData(_converter.toAriesSendProofResponseDto(value)));
  }
}
