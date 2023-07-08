import 'package:flutter_vcx_demo/src/connections/domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class InviteeAcceptConnectionInvitationUseCase {
  late final IConnectionRepository _ariesConnectionRepository;

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
