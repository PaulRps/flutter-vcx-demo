import 'dart:convert';

import 'package:injectable/injectable.dart';

import '../dtos/wallet_data.dto.dart';
import 'local_storage.service.dart';

const String walletDataStorage = "walletDataStorage";

@Named(walletDataStorage)
@LazySingleton(as: EncryptedLocalStorage)
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
