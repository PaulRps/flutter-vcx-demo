import 'package:flutter_vcx_demo/src/wallet/data/aries_sdk.datasource.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'sdk.converter.dart';

@LazySingleton(as: ISdkRepository)
class AriesSdkRepository implements ISdkRepository {
  late final IAriesSdkDatasource _ariesDatasource;
  late final SdkConverter _converter;

  AriesSdkRepository(this._ariesDatasource, this._converter);

  @override
  Future<bool> startSdk(SdkSettings dto) {
    return _ariesDatasource
        .startSdk(_converter.toFlutterRequestAriesSdkChannelDto(dto))
        .then((value) => value.success);
  }

  @override
  Future<bool> shutdownSdk({required bool deleteWallet}) {
    return _ariesDatasource
        .shutdownSdk(SdkConverter.fromBool(deleteWallet))
        .then((value) => value.success);
  }
}
