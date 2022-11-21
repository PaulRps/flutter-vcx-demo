import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_proof.repository.dart';

import '../../data/dtos/aries_send_proof_response.dto.dart';

class VerifierSendProofRequestUseCase {
  late final IAriesConnectionRepository _connectionRepository;
  late final IAriesProofRepository _proofRepository;

  VerifierSendProofRequestUseCase({connectionRepository, proofRepository})
      : _connectionRepository =
            connectionRepository ?? AriesConnectionRepository(),
        _proofRepository = proofRepository ?? AriesProofRepository();

  Future<AriesSendProofResponseDto> sendRequest() {
    return _connectionRepository.getConnectionData().then((value) =>
        _proofRepository.sendProofRequest(FlutterRequestAriesProofChannelDto(
            pairwiseDid: value.pairwiseDid)));
  }
}
