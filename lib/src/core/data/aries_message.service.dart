import 'package:aries_api/aries_api.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesMessageService {
  Future<dynamic> getMessageByPwDid(FlutterRequestAriesMessageChannelDto dto);
}

@LazySingleton(as: IAriesMessageService)
class AriesMessageService implements IAriesMessageService {
  late final AriesMessageApi _ariesMessageApi;

  AriesMessageService(this._ariesMessageApi);

  @override
  Future<dynamic> getMessageByPwDid(FlutterRequestAriesMessageChannelDto dto) {
    return _ariesMessageApi.getMessageByPwDid(dto.toJson());
  }
}
