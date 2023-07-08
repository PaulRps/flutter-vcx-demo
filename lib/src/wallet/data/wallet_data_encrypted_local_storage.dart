import 'dart:convert';

import 'package:flutter_vcx_demo/src/core/core.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/domain.dart';
import 'package:injectable/injectable.dart';

const String walletDataStorage = "walletDataStorage";

@Named(walletDataStorage)
@LazySingleton(as: EncryptedLocalStorage)
class WalletDataEncryptedLocaStorage extends EncryptedLocalStorage<WalletData> {
  @override
  String dataRef = WalletData.WALLET_REF;

  @override
  WalletData toData(String data) {
    return WalletData.fromJson(jsonDecode(data));
  }

  @override
  String toJsonString(WalletData data) {
    return jsonEncode(data.toJson());
  }
}
