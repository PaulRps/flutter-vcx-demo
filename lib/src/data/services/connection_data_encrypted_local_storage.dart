import 'dart:convert';

import 'package:flutter_vcx_demo/src/data/dtos/connection_data.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/local_storage.service.dart';

class ConnectionDataEncryptedLocalStorage
    extends EncryptedLocalStorage<List<ConnectionDataDto>> {
  @override
  String dataRef = ConnectionDataDto.CONNECTION_REF;

  @override
  List<ConnectionDataDto> toData(String data) {
    return (jsonDecode(data) as List)
        .map((e) => ConnectionDataDto.fromJson(e))
        .toList();
  }

  @override
  String toJsonString(List<ConnectionDataDto> data) {
    return jsonEncode(data.map((e) => e.toJson()).toList());
  }
}
