import 'dart:convert';

import 'package:flutter_vcx_demo/src/connections/domain/entities/entities.dart';
import 'package:injectable/injectable.dart';

import '../connection.repository.dart';

@Injectable()
class InviterCreateConnectionInvitationUseCase {
  late final IConnectionRepository _ariesConnectionRepository;

  InviterCreateConnectionInvitationUseCase(this._ariesConnectionRepository);

  Future<ConnectionInvitationData> createInvite() {
    return _ariesConnectionRepository
        .createConnectionInvitation()
        .then((value) => _parseInvitation(value));
  }

  ConnectionInvitationData _parseInvitation(ConnectionInvitationData dto) {
    var bytes = utf8.encode(dto.inviteUrl!);
    var connectionInvitation = base64.encode(bytes);
    var inviteUrl = "http://my.host?c_i=$connectionInvitation";
    return ConnectionInvitationData(inviteUrl, dto.connectionHandle!);
  }
}
