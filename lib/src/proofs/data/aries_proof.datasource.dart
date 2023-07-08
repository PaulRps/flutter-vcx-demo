import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

import 'aries_proof.service.dart';

abstract class IAriesProofDatasource {
  Future presentProof(FlutterRequestAriesProofChannelDto dto);

  Future rejectProof(FlutterRequestAriesProofChannelDto dto);

  Future sendProofRequest(FlutterRequestAriesProofChannelDto dto);
}

@LazySingleton(as: IAriesProofDatasource)
class AriesProofDatasource implements IAriesProofDatasource {
  late final IAriesProofService _ariesProofService;

  AriesProofDatasource(this._ariesProofService);

  @override
  Future presentProof(FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofService.presentProof(dto);
  }

  @override
  Future rejectProof(FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofService.rejectProof(dto);
  }

  @override
  Future sendProofRequest(FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofService.sendProofRequest(dto);
  }
}
