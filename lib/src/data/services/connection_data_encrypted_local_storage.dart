import 'dart:convert';

import 'package:flutter_vcx_demo/src/data/dtos/connection_data.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/local_storage.service.dart';

class ConnectionDataEncryptedLocalStorage
    extends EncryptedLocalStorage<ConnectionDataDto> {
  @override
  String dataRef = ConnectionDataDto.CONNECTION_REF;

  @override
  ConnectionDataDto toData(String data) {
    return ConnectionDataDto.fromJson(jsonDecode(data));
  }

  @override
  String toJsonString(ConnectionDataDto data) {
    return jsonEncode(data.toJson());
  }
}
