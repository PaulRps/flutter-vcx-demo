import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_proof.repository.dart';

class SendProofRequest {
  late final IAriesConnectionRepository _connectionRepository;
  late final IAriesProofRepository _proofRepository;

  SendProofRequest({connectionRepository, proofRepository})
      : _connectionRepository =
            connectionRepository ?? AriesConnectionRepository(),
        _proofRepository = proofRepository ?? AriesProofRepository();

  Future sendRequest() {
    return _connectionRepository
        .getConnectionData()
        .then((value) => _proofRepository.sendProofRequest(
            FlutterRequestAriesProofChannelDto(pairwiseDid: value.pairwiseDid)))
        .then((value) => value.success);
  }
}
