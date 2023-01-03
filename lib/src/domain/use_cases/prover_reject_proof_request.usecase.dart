import 'package:injectable/injectable.dart';

import '../../data/dtos/flutter_request_aries_proof_channel.dto.dart';
import '../../data/repositories/aries_connection.repository.dart';
import '../../data/repositories/aries_proof.repository.dart';

@Injectable()
class ProverRejectProofRequestUseCase {
  late final IAriesProofRepository _ariesProofRepository;
  late final IAriesConnectionRepository _ariesConnectionRepository;

  ProverRejectProofRequestUseCase(
      this._ariesProofRepository, this._ariesConnectionRepository);

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
