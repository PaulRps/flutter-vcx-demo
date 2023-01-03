import 'package:flutter_vcx_demo/src/data/dtos/aries_connection_invitation.dto.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesConnectionUrlParserService {
  AriesConnectionInvitationDto? parse(String connectionUrl);
}

@LazySingleton(as: IAriesConnectionUrlParserService)
class AriesConnectionParserService implements IAriesConnectionUrlParserService {
  @override
  AriesConnectionInvitationDto? parse(String connectionUrl) {
    AriesConnectionInvitationDto? invitation;
    try {
      var uri = Uri.parse(connectionUrl);

      var base64 = uri.queryParameters["c_i"];

      invitation = AriesConnectionInvitationDto.fromBase64(base64!);
    } catch (e) {}

    return invitation;
  }
}
