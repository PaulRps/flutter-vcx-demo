import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_credential_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/aries/aries_credential_native.channel.dart';
import 'package:flutter_vcx_demo/src/data/native_channels/native_channel.dart';

abstract class IAriesCredentialService {
  Future acceptCredentialOffer(FlutterRequestAriesCredentialChannelDto dto);

  Future getCredentials();
}

class AriesCredentialService implements IAriesCredentialService {
  late final INativeChannel _channel;

  AriesCredentialService({channel})
      : _channel = channel ?? AriesCredentialNativeChannel();

  @override
  Future acceptCredentialOffer(FlutterRequestAriesCredentialChannelDto dto) {
    return _channel.callMethod("acceptOffer", argument: dto.toJson());
  }

  @override
  Future getCredentials() {
    return _channel.callMethod("getCredentials");
  }
}
