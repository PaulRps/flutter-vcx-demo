import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_message_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/enums/aries_agency_message_status.enum.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_message.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetAriesMessageByPwDidUseCase {
  final IAriesMessageRepository _ariesMessageRepository;

  GetAriesMessageByPwDidUseCase(this._ariesMessageRepository);

  Future getMessageBy(String pairwiseDid) {
    var dto = FlutterRequestAriesMessageChannelDto.from(
        msgStatus: AriesAgencyMessageStatusEnum.received,
        msgUuid: "",
        pairwiseDid: pairwiseDid);
    return _ariesMessageRepository.getMessageByPwDid(dto);
  }
}
