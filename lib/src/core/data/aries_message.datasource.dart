import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

import 'aries_message.service.dart';

abstract class IAriesMessageDatasource {
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto);
}

@LazySingleton(as: IAriesMessageDatasource)
class AriesMessageDatasource implements IAriesMessageDatasource {
  final IAriesMessageService _ariesMessageService;

  AriesMessageDatasource(this._ariesMessageService);

  @override
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      FlutterRequestAriesMessageChannelDto dto) {
    return _ariesMessageService
        .getMessageByPwDid(dto)
        .then((value) => AriesGetMessageResponseDto.fromJson(value));
  }
}
