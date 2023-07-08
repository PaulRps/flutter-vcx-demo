import 'package:flutter_vcx_demo/src/proofs/domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class VerifierSendProofRequestUseCase {
  late final IAriesProofRepository _proofRepository;

  VerifierSendProofRequestUseCase(this._proofRepository);

  Future<ProofRequestedData> sendRequest(
      {sourceId, pairwiseDid, requestedAttributes}) {
    if (sourceId == null || sourceId?.toString().isEmpty == true) {
      return Future.error("sourceId is required");
    }

    if (pairwiseDid == null || pairwiseDid?.toString().isEmpty == true) {
      return Future.error("pairwiseDid is required");
    }

    if (requestedAttributes == null || (requestedAttributes as List).isEmpty) {
      return Future.error("requested attributes is required");
    }
    var flutterRequestAriesProofChannelDto = ProofRequest(
        sourceId: sourceId,
        proofName: "flutter-vcx-demo-proof",
        requestedAttributes: requestedAttributes as List<RequestedAttribute>,
        pairwiseDid: pairwiseDid);
    return _proofRepository
        .sendProofRequest(flutterRequestAriesProofChannelDto);
  }
}
