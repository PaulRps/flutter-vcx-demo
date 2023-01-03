import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_proof.repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/dtos/aries_request_proof_attribute.dto.dart';
import '../../data/dtos/aries_send_proof_response.dto.dart';

@Injectable()
class VerifierSendProofRequestUseCase {
  late final IAriesProofRepository _proofRepository;

  VerifierSendProofRequestUseCase(this._proofRepository);

  Future<AriesSendProofResponseDto> sendRequest(
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
    var flutterRequestAriesProofChannelDto = FlutterRequestAriesProofChannelDto(
        sourceId: sourceId,
        proofName: "flutter-vcx-demo-proof",
        requestedAttributes:
            requestedAttributes as List<AriesRequestedProofAttributeDto>,
        pairwiseDid: pairwiseDid);
    return _proofRepository
        .sendProofRequest(flutterRequestAriesProofChannelDto);
  }
}
