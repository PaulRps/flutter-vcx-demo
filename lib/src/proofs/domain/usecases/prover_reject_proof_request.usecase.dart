import 'package:flutter_vcx_demo/src/connections/connections.dart';
import 'package:injectable/injectable.dart';

import '../proof.repository.dart';

@Injectable()
class ProverRejectProofRequestUseCase {
  late final IAriesProofRepository _ariesProofRepository;
  late final IConnectionRepository _ariesConnectionRepository;

  ProverRejectProofRequestUseCase(
      this._ariesProofRepository, this._ariesConnectionRepository);

  Future<bool> reject() {
    return _ariesConnectionRepository.getConnectionsData().then((connections) {
      var connection =
          connections.firstWhere((e) => e.connectionName?.isNotEmpty == true);

      return _ariesProofRepository.rejectProof(
          pairwiseDid: connection.pairwiseDid!, sourceId: "flutterVcxDemo");
    });
  }
}
