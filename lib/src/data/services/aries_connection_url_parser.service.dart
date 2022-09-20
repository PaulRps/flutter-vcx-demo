import 'package:flutter_vcx_demo/src/data/dtos/aries_connection_invitation.dto.dart';

abstract class IAriesConnectionUrlParserService {
  AriesConnectionInvitationDto? parse(String connectionUrl);
}

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
