import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_proof.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ProverPresentProofRequestUseCase {
  late final IAriesProofRepository _ariesProofRepository;
  late final IAriesConnectionRepository _ariesConnectionRepository;

  ProverPresentProofRequestUseCase(
      this._ariesProofRepository, this._ariesConnectionRepository);

  Future<bool> presentProof() {
    return _ariesConnectionRepository.getConnectionsData().then((connections) {
      var connection =
          connections.firstWhere((e) => e.connectionName?.isNotEmpty == true);
      var dto = FlutterRequestAriesProofChannelDto(
          pairwiseDid: connection.pairwiseDid, sourceId: "flutterVcxDemo");
      return _ariesProofRepository
          .presentProof(dto)
          .then((value) => value.success);
    });
  }
}
