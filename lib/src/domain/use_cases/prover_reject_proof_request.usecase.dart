import '../../data/dtos/flutter_request_aries_proof_channel.dto.dart';
import '../../data/repositories/aries_connection.repository.dart';
import '../../data/repositories/aries_proof.repository.dart';

class ProverRejectProofRequestUseCase {
  late final AriesProofRepository _ariesProofRepository;
  late final AriesConnectionRepository _ariesConnectionRepository;

  ProverRejectProofRequestUseCase(
      {ariesProofRepository, ariesConnectionRepository})
      : _ariesProofRepository =
            ariesConnectionRepository ?? AriesProofRepository(),
        _ariesConnectionRepository =
            ariesConnectionRepository ?? AriesConnectionRepository();

  Future<bool> reject() {
    return _ariesConnectionRepository.getConnectionsData().then((connections) {
      var connection =
          connections.firstWhere((e) => e.connectionName?.isNotEmpty == true);
      var dto = FlutterRequestAriesProofChannelDto(
          pairwiseDid: connection.pairwiseDid, sourceId: "flutterVcxDemo");

      return _ariesProofRepository
          .rejectProof(dto)
          .then((value) => value.success);
    });
  }
}
