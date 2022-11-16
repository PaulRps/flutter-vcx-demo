import '../../data/dtos/flutter_request_aries_proof_channel.dto.dart';
import '../../data/repositories/aries_connection.repository.dart';
import '../../data/repositories/aries_proof.repository.dart';

class RejectProofRequestUseCase {
  late final AriesProofRepository _ariesProofRepository;
  late final AriesConnectionRepository _ariesConnectionRepository;

  RejectProofRequestUseCase({ariesProofRepository, ariesConnectionRepository})
      : _ariesProofRepository =
            ariesConnectionRepository ?? AriesProofRepository(),
        _ariesConnectionRepository =
            ariesConnectionRepository ?? AriesConnectionRepository();

  Future<bool> reject() {
    return _ariesConnectionRepository.getConnectionData().then((connection) {
      var dto = FlutterRequestAriesProofChannelDto(
          pairwiseDid: connection.pairwiseDid, sourceId: "flutterVcxDemo");

      return _ariesProofRepository
          .rejectProof(dto)
          .then((value) => value.success);
    });
  }
}
