import 'package:aries_api/src/connection_api/models/flutter_request_aries_connection_channel.dto.dart';

import '../native_channel.dart';
import 'aries_connection_native.channel.dart';

class AriesConnectionApi {
  final INativeChannel _channel = AriesConnectionNativeChannel();

  Future<dynamic> createConnection(
      FlutterRequestAriesConnectionChannelDto json) {
    return _channel.callMethod("create", argument: json.toJson());
  }

  Future<dynamic> checkConnectionInvitation(
      FlutterRequestAriesConnectionChannelDto json) {
    return _channel.callMethod("checkInvitation", argument: json.toJson());
  }

  Future<dynamic> createConnectionInvitation() {
    return _channel.callMethod("invitation");
  }
}
