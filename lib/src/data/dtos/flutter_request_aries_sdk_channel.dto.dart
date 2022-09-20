import 'dart:convert';

import 'package:flutter_vcx_demo/src/data/dtos/aries_sdk_config.dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'flutter_request_aries_sdk_channel.dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FlutterRequestAriesSdkChannelDto {
  AriesSdkConfigDto? config;
  bool? isToDeleteWallet;

  FlutterRequestAriesSdkChannelDto(this.config, this.isToDeleteWallet);

  FlutterRequestAriesSdkChannelDto.from(
      {required agencyEndpoint,
      required genesisPath,
      required walletName,
      required walletKey})
      : config = AriesSdkConfigDto.from(
            agencyEndpoint, genesisPath, walletName, walletKey);

  factory FlutterRequestAriesSdkChannelDto.fromJson(
          Map<String, dynamic> json) =>
      _$FlutterRequestAriesSdkChannelDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FlutterRequestAriesSdkChannelDtoToJson(this);
}
