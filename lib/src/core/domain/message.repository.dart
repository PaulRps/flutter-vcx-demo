import 'package:aries_api/aries_api.dart';

import 'entities/message_status.dart';

abstract class IAriesMessageRepository {
  Future<AriesGetMessageResponseDto> getMessageByPwDid(
      {required MessageStatus msgStatus,
      required String pairwiseDid,
      String msgUuid});
}
