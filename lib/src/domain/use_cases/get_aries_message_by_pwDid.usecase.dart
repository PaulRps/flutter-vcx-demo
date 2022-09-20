import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_message_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/enums/aries_agency_message_status.enum.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_message.repository.dart';

class GetAriesMessageByPwDidUsecase {
  final IAriesMessageRepository _ariesMessageRepository;

  GetAriesMessageByPwDidUsecase({ariesMessageRepository})
      : _ariesMessageRepository =
            ariesMessageRepository ?? AriesMessageRepository();

  Future getMessageBy(String pairwiseDid) {
    var dto = FlutterRequestAriesMessageChannelDto.from(
        msgStatus: AriesAgencyMessageStatusEnum.received,
        msgUuid: "",
        pairwiseDid: pairwiseDid);
    return _ariesMessageRepository.getMessageByPwDid(dto);
  }
}
