import 'dart:convert';

import 'package:flutter_vcx_demo/src/domain/entities/connection_invitation_data.dart';
import 'package:injectable/injectable.dart';

import '../../data/dtos/aries_connection_invitation_response.dto.dart';
import '../../data/repositories/aries_connection.repository.dart';

@Injectable()
class InviterCreateConnectionInvitationUseCase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

  InviterCreateConnectionInvitationUseCase(this._ariesConnectionRepository);

  Future<ConnectionInvitationData> createInvite() {
    return _ariesConnectionRepository
        .createConnectionInvitation()
        .then((value) => _parseInvitation(value));
  }

  ConnectionInvitationData _parseInvitation(
      AriesConnectionInvitationResponseDto dto) {
    var bytes = utf8.encode(dto.invitation!);
    var connectionInvitation = base64.encode(bytes);
    var inviteUrl = "http://my.host?c_i=$connectionInvitation";
    return ConnectionInvitationData(inviteUrl, dto.connectionHandle!);
  }
}
