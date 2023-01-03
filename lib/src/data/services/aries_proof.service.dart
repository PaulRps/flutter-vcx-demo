import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_proof_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/aries/aries_proof_native.channel.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesProofService {
  Future<dynamic> presentProof(FlutterRequestAriesProofChannelDto dto);

  Future rejectProof(FlutterRequestAriesProofChannelDto dto);

  Future sendProofRequest(FlutterRequestAriesProofChannelDto dto);
}

@LazySingleton(as: IAriesProofService)
class AriesProofService implements IAriesProofService {
  late final INativeChannel _channel;

  AriesProofService(@Named(ariesProofChannel) this._channel);

  @override
  Future presentProof(FlutterRequestAriesProofChannelDto dto) {
    return _channel.callMethod("presentProof", argument: dto.toJson());
  }

  @override
  Future rejectProof(FlutterRequestAriesProofChannelDto dto) {
    return _channel.callMethod("rejectProof", argument: dto.toJson());
  }

  @override
  Future sendProofRequest(FlutterRequestAriesProofChannelDto dto) {
    return _channel.callMethod("sendRequest", argument: dto.toJson());
  }
}
