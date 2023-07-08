import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/entities/sdk_settings.dart';
import 'package:injectable/injectable.dart';
import 'package:smartstruct/smartstruct.dart';

part 'sdk.converter.mapper.g.dart';

@Mapper(useInjection: true)
abstract class SdkConverter {
  @IgnoreMapping()
  static FlutterRequestAriesSdkChannelDto fromBool(bool isToDeleteWallet) =>
      FlutterRequestAriesSdkChannelDto(isToDeleteWallet: isToDeleteWallet);

  AriesSdkConfigDto toAriesSdkConfigDto(SdkSettings from);

  FlutterRequestAriesSdkChannelDto toFlutterRequestAriesSdkChannelDto(
      SdkSettings to);
}
