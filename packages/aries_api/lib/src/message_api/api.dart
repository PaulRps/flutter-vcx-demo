import '../native_channel.dart';
import 'aries_message_native.channel.dart';

class AriesMessageApi {
  final INativeChannel _channel = AriesMessageNativeChannel();

  Future<dynamic> getMessageByPwDid(Map<String, dynamic> json) {
    return _channel.callMethod("getOneByPwDid", argument: json);
  }
}
