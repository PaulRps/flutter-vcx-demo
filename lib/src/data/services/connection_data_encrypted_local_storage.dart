import 'dart:convert';

import 'package:flutter_vcx_demo/src/data/dtos/connection_data.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/local_storage.service.dart';
import 'package:injectable/injectable.dart';

const String connectionDataStorage = "connectionDataStorage";

@Named(connectionDataStorage)
@LazySingleton(as: EncryptedLocalStorage)
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
