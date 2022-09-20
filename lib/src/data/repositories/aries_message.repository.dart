import 'package:flutter_vcx_demo/src/data/datasources/aries_message.datasource.dart';

import '../dtos/aries_get_message_response.dto.dart';
import '../dtos/flutter_request_aries_message_channel.dto.dart';

abstract class IAriesMessageRepository {
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto);
}

class AriesMessageRepository implements IAriesMessageRepository {
  final IAriesMessageDatasource _ariesMessageDatasource;

  AriesMessageRepository({ariesMessageDatasource})
      : _ariesMessageDatasource =
            ariesMessageDatasource ?? AriesMessageDatasource();

  @override
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto) {
    return _ariesMessageDatasource.getMessageByPwDid(dto);
  }
}
