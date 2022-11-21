import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';

import '../entities/connection_data.dart';

class InviteeAcceptConnectionInvitationUseCase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

  InviteeAcceptConnectionInvitationUseCase({ariesConnectionRepository})
      : _ariesConnectionRepository =
            ariesConnectionRepository ?? AriesConnectionRepository();

  Future<ConnectionData> createConnection({required connectionUrl}) {
    return _ariesConnectionRepository
        .createConnection(connectionUrl, "flutterVcxDemoID_${DateTime.now()}")
        .then((connectionData) {
      return _ariesConnectionRepository
          .saveConnectionData(connectionData)
          .then((value) => connectionData);
    });
  }
}
