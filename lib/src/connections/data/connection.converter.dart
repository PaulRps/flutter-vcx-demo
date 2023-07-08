import 'package:aries_api/aries_api.dart';
import 'package:flutter_vcx_demo/src/connections/connections.dart';
import 'package:smartstruct/smartstruct.dart';
import 'package:injectable/injectable.dart';

part 'connection.converter.mapper.g.dart';

@Mapper(useInjection: true)
abstract class ConnectionConverter {
  ConnectionData toConnectionData(AriesCreateConnectionResponseDto from);

  @Mapping(target: "inviteUrl", source: "from.invitation")
  ConnectionInvitationData toConnectionInvitationData(
      AriesConnectionInvitationResponseDto from);
}
