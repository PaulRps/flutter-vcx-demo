import '../native_channel.dart';
import 'aries_credential_native.channel.dart';
import 'models/flutter_request_aries_credential_channel.dto.dart';

class AriesCredentialApi {
  final INativeChannel _channel = AriesCredentialNativeChannel();

  Future acceptCredentialOffer(FlutterRequestAriesCredentialChannelDto dto) {
    return _channel.callMethod("acceptOffer", argument: dto.toJson());
  }

  Future getCredentials() {
    return _channel.callMethod("getCredentials");
  }
}
