import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';

import '../services/aries_proof.service.dart';

abstract class IAriesProofDatasource {
  Future presentProof(FlutterRequestAriesProofChannelDto dto);
}

class AriesProofDatasource implements IAriesProofDatasource {
  late final IAriesProofService _ariesProofService;

  AriesProofDatasource({ariesProofService})
      : _ariesProofService = ariesProofService ?? AriesProofService();

  @override
  Future presentProof(FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofService.presentProof(dto);
  }
}
