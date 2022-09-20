// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutter_request_aries_sdk_channel.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlutterRequestAriesSdkChannelDto _$FlutterRequestAriesSdkChannelDtoFromJson(
        Map<String, dynamic> json) =>
    FlutterRequestAriesSdkChannelDto(
      json['config'] == null
          ? null
          : AriesSdkConfigDto.fromJson(json['config'] as Map<String, dynamic>),
      json['isToDeleteWallet'] as bool?,
    );

Map<String, dynamic> _$FlutterRequestAriesSdkChannelDtoToJson(
        FlutterRequestAriesSdkChannelDto instance) =>
    <String, dynamic>{
      'config': instance.config?.toJson(),
      'isToDeleteWallet': instance.isToDeleteWallet,
    };
