import 'package:json_annotation/json_annotation.dart';

part 'wallet_data.g.dart';

@JsonSerializable()
class WalletData {
  static const String WALLET_REF = "wallet_key";

  String name;
  String key;

  WalletData({required this.name, required this.key});

  factory WalletData.fromJson(Map<String, dynamic> json) =>
      _$WalletDataFromJson(json);

  Map<String, dynamic> toJson() => _$WalletDataToJson(this);
}
