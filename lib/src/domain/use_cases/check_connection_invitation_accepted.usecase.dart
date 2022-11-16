import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';

import '../../data/repositories/aries_connection.repository.dart';

class CheckConnectionInvitationAcceptedUseCase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

  CheckConnectionInvitationAcceptedUseCase({ariesConnectionRepository})
      : _ariesConnectionRepository =
            ariesConnectionRepository ?? AriesConnectionRepository();

  Future<ConnectionData> isInvitationAccepted(String connectionHandle, bool isToDeleteHandle) {
    return _ariesConnectionRepository
        .checkConnectionInvitation(connectionHandle, isToDeleteHandle)
        .then((value) async {
      var connectionData =
          ConnectionData(value.pairwiseDid ?? "", value.connectionName ?? "");

      if (value.pairwiseDid?.isNotEmpty == true) {
        await _ariesConnectionRepository.saveConnectionData(connectionData);
      }

      return connectionData;
    });
  }
}
