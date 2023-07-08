import 'package:json_annotation/json_annotation.dart';

import 'wallet_key_derivation.enum.dart';


part 'aries_local_wallet_config.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AriesLocalWalletConfigDto {
  String? walletName;

  String? walletKey;

  WalletKeyDerivationEnum? walletKeyDerivation;

  AriesLocalWalletConfigDto(
      this.walletName, this.walletKey, this.walletKeyDerivation);

  factory AriesLocalWalletConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AriesLocalWalletConfigDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AriesLocalWalletConfigDtoToJson(this);
}
