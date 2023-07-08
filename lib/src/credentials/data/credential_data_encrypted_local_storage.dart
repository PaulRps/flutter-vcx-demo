import 'dart:convert';

import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/core/core.dart';
import 'package:injectable/injectable.dart';

const String credentialDataStorage = "credentialDataStorage";

@Named(credentialDataStorage)
@LazySingleton(as: EncryptedLocalStorage)
class CredentialDataEncryptedLocalStorage
    extends EncryptedLocalStorage<List<AriesCredentialDto>> {
  @override
  String dataRef = AriesCredentialDto.CREDENTIAL_REF;

  @override
  List<AriesCredentialDto> toData(String data) {
    return (jsonDecode(data) as List)
        .map((e) => AriesCredentialDto.fromJson(e))
        .toList();
  }

  @override
  String toJsonString(List<AriesCredentialDto> data) {
    return jsonEncode(data);
  }
}
