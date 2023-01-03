import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/connection_data.dart';

@Injectable()
class InviteeAcceptConnectionInvitationUseCase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

  InviteeAcceptConnectionInvitationUseCase(this._ariesConnectionRepository);

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
