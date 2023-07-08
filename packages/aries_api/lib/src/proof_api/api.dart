import '../native_channel.dart';
import 'aries_proof_native.channel.dart';

class AriesProofApi {
  final INativeChannel _channel = AriesProofNativeChannel();

  Future presentProof(Map<String, dynamic> json) {
    return _channel.callMethod("presentProof", argument: json);
  }

  Future rejectProof(Map<String, dynamic> json) {
    return _channel.callMethod("rejectProof", argument: json);
  }

  Future sendProofRequest(Map<String, dynamic> json) {
    return _channel.callMethod("sendRequest", argument: json);
  }
}
