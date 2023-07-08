import 'entities/entities.dart';

abstract class IAriesProofRepository {
  Future<bool> presentProof(
      {required String pairwiseDid, required String sourceId});

  Future<bool> rejectProof(
      {required String pairwiseDid, required String sourceId});

  Future<ProofRequestedData> sendProofRequest(ProofRequest dto);
}
