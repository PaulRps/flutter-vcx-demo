import '../native_channel.dart';
import 'aries_sdk_native.channel.dart';

class AriesSdkApi {
  final INativeChannel _channel = AriesSdkNativeChannel();

  Future<dynamic> startSdk(Map<String, dynamic> json) {
    return _channel.callMethod("start", argument: json);
  }

  Future<dynamic> shutdownSdk(Map<String, dynamic> json) {
    return _channel.callMethod("shutdown", argument: json);
  }
}
