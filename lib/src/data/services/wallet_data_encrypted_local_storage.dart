import 'dart:convert';

import '../dtos/wallet_data.dto.dart';
import 'local_storage.service.dart';

class WalletDataEncryptedLocaStorage extends EncryptedLocalStorage<WalletDataDto> {

  @override
  String dataRef = WalletDataDto.WALLET_REF;

  @override
  WalletDataDto toData(String data) {
    return WalletDataDto.fromJson(jsonDecode(data));
  }

  @override
  String toJsonString(WalletDataDto data) {
    return jsonEncode(data.toJson());
  }

}
