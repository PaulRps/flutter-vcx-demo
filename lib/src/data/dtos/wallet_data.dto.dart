
import 'package:json_annotation/json_annotation.dart';

part 'wallet_data.dto.g.dart';

@JsonSerializable()
class WalletDataDto {
  static const String WALLET_REF = "wallet_key";

  String name;
  String key;

  WalletDataDto(this.name, this.key);

  factory WalletDataDto.fromJson(Map<String, dynamic> json) =>
      _$WalletDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$WalletDataDtoToJson(this);
}