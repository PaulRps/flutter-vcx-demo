import 'package:flutter_vcx_demo/src/data/dtos/aries_get_message_response.dto.dart';
import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_message_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/services/aries_message.service.dart';

abstract class IAriesMessageDatasource {
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto);
}

class AriesMessageDatasource implements IAriesMessageDatasource {
  final IAriesMessageService _ariesMessageService;

  AriesMessageDatasource({ariesMessageService})
      : _ariesMessageService = ariesMessageService ?? AriesMessageService();

  @override
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto) {
    return _ariesMessageService
        .getMessageByPwDid(dto)
        .then((value) => AriesGetMessageResponseDto.fromJson(value));
  }
}
