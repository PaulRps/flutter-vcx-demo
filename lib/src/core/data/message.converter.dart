import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/core/core.dart';
import 'package:smartstruct/smartstruct.dart';
import 'package:injectable/injectable.dart';

part 'message.converter.mapper.g.dart';

@Mapper(useInjection: true)
abstract class MessageConverter {
  @IgnoreMapping()
  AriesAgencyMessageStatusEnum toAriesAgencyMessageStatusEnum(
      MessageStatus from) {
    switch (from) {
      case MessageStatus.received:
        return AriesAgencyMessageStatusEnum.received;
    }
  }
}
