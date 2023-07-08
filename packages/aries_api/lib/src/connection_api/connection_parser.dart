import 'models/aries_connection_invitation.dto.dart';

class AriesConnectionParser {
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
