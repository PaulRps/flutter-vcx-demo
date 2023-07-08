import 'package:aries_api/aries_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flutter_request_aries_sdk_channel.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FlutterRequestAriesSdkChannelDto {
  AriesSdkConfigDto? config;
  bool? isToDeleteWallet;

  FlutterRequestAriesSdkChannelDto({this.config, this.isToDeleteWallet});

  FlutterRequestAriesSdkChannelDto.fromConfig(
      {required agencyEndpoint,
      required genesisPath,
      required walletName,
      required walletKey})
      : this(
            config: AriesSdkConfigDto.from(
                agencyEndpoint, genesisPath, walletName, walletKey));

  factory FlutterRequestAriesSdkChannelDto.fromJson(
          Map<String, dynamic> json) =>
      _$FlutterRequestAriesSdkChannelDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FlutterRequestAriesSdkChannelDtoToJson(this);
}
