import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class InviterCheckConnectionInvitationAcceptedUseCase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

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
