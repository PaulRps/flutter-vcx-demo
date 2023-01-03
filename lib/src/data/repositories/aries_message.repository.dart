import 'package:flutter_vcx_demo/src/data/datasources/aries_message.datasource.dart';
import 'package:injectable/injectable.dart';

import '../dtos/aries_get_message_response.dto.dart';
import '../dtos/flutter_request_aries_message_channel.dto.dart';

abstract class IAriesMessageRepository {
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto);
}

@LazySingleton(as: IAriesMessageRepository)
class AriesMessageRepository implements IAriesMessageRepository {
  final IAriesMessageDatasource _ariesMessageDatasource;

  AriesMessageRepository(this._ariesMessageDatasource);

  @override
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto) {
    return _ariesMessageDatasource.getMessageByPwDid(dto);
  }
}
