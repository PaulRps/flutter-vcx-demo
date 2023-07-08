import 'package:flutter_vcx_demo/src/core/domain/entities/message_status.dart';
import 'package:injectable/injectable.dart';

import '../message.repository.dart';

@Injectable()
class GetAriesMessageByPwDidUseCase {
  final IAriesMessageRepository _ariesMessageRepository;

  GetAriesMessageByPwDidUseCase(this._ariesMessageRepository);

  Future getMessageBy(String pairwiseDid) {
    return _ariesMessageRepository.getMessageByPwDid(
        msgStatus: MessageStatus.received,
        msgUuid: "",
        pairwiseDid: pairwiseDid);
  }
}
