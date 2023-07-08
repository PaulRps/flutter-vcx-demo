import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/core/data/aries_message.datasource.dart';
import 'package:flutter_vcx_demo/src/core/domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'message.converter.dart';

@LazySingleton(as: IAriesMessageRepository)
class AriesMessageRepository implements IAriesMessageRepository {
  late final IAriesMessageDatasource _ariesMessageDatasource;
  late final MessageConverter _converter;

  AriesMessageRepository(this._ariesMessageDatasource, this._converter);

  @override
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      {required MessageStatus msgStatus,
      required String pairwiseDid,
      String msgUuid = ""}) {
    return _ariesMessageDatasource.getMessageByPwDid(
        FlutterRequestAriesMessageChannelDto(msgUuid,
            _converter.toAriesAgencyMessageStatusEnum(msgStatus), pairwiseDid));
  }
}
