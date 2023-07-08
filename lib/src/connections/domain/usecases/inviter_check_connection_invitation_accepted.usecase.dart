import 'package:flutter_vcx_demo/src/connections/domain/entities/connection_data.dart';
import 'package:injectable/injectable.dart';

import '../connection.repository.dart';

@Injectable()
class InviterCheckConnectionInvitationAcceptedUseCase {
  late final IConnectionRepository _ariesConnectionRepository;

  InviterCheckConnectionInvitationAcceptedUseCase(
      this._ariesConnectionRepository);

  Future<ConnectionData> isInvitationAccepted(
      {connectionHandle, isToDeleteHandle}) {
    return _ariesConnectionRepository
        .checkConnectionInvitation(connectionHandle, isToDeleteHandle)
        .then((value) async {
      var connectionData = ConnectionData(
          pairwiseDid: value.pairwiseDid ?? "",
          connectionName: value.connectionName ?? "");

      if (value.pairwiseDid?.isNotEmpty == true) {
        await _ariesConnectionRepository.saveConnectionData(connectionData);
      }

      return connectionData;
    });
  }
}
