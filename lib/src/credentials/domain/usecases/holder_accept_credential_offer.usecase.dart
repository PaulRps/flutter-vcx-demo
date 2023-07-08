import 'package:flutter_vcx_demo/src/connections/connections.dart';
import 'package:flutter_vcx_demo/src/credentials/domain/domain.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HolderAcceptCredentialOfferUseCase {
  late final ICredentialRepository _ariesCredentialRepository;
  late final IConnectionRepository _ariesConnectionRepository;

  HolderAcceptCredentialOfferUseCase(
      this._ariesCredentialRepository, this._ariesConnectionRepository);

  Future<Credential> acceptOffer() {
    return _ariesConnectionRepository.getConnectionsData().then((connections) {
      var connection =
          connections.firstWhere((e) => e.connectionName?.isNotEmpty == true);
      return _ariesCredentialRepository
          .acceptCredentialOffer(
              pairwiseDid: connection.pairwiseDid!, sourceId: "flutterVcxDemo")
          .then((credential) {
        return _ariesCredentialRepository
            .saveCredentialData(credential)
            .then((value) => credential);
      });
    });
  }
}
