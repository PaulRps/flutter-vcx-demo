import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesProofService {
  Future<dynamic> presentProof(FlutterRequestAriesProofChannelDto dto);

  Future rejectProof(FlutterRequestAriesProofChannelDto dto);

  Future sendProofRequest(FlutterRequestAriesProofChannelDto dto);
}

@LazySingleton(as: IAriesProofService)
class AriesProofService implements IAriesProofService {
  late final AriesProofApi _ariesProofApi;

  AriesProofService(this._ariesProofApi);

  @override
  Future presentProof(FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofApi.presentProof(dto.toJson());
  }

  @override
  Future rejectProof(FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofApi.rejectProof(dto.toJson());
  }

  @override
  Future sendProofRequest(FlutterRequestAriesProofChannelDto dto) {
    return _ariesProofApi.sendProofRequest(dto.toJson());
  }
}
