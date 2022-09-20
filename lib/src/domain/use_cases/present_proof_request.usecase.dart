import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_proof.repository.dart';

class PresentProofRequestUsecase {
  late final AriesProofRepository _ariesProofRepository;
  late final AriesConnectionRepository _ariesConnectionRepository;

  PresentProofRequestUsecase({ariesProofRepository, ariesConnectionRepository})
      : _ariesProofRepository = ariesConnectionRepository ?? AriesProofRepository(),
        _ariesConnectionRepository = ariesConnectionRepository ?? AriesConnectionRepository();

  Future presentProof() {
    return _ariesConnectionRepository.getConnectionData().then((connection) {
      var dto = FlutterRequestAriesProofChannelDto(
          connection.pairwiseDid, "flutterVcxDemo");
      return _ariesProofRepository
          .presentProof(dto)
          .then((value) => value.success);
    });
  }
}
