import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_credential_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_credential.repository.dart';
import 'package:flutter_vcx_demo/src/domain/entities/credential_data.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class HolderAcceptCredentialOfferUseCase {
  late final IAriesCredentialRepository _ariesCredentialRepository;
  late final IAriesConnectionRepository _ariesConnectionRepository;

  HolderAcceptCredentialOfferUseCase(
      this._ariesCredentialRepository, this._ariesConnectionRepository);

  Future<CredentialData> acceptOffer() {
    return _ariesConnectionRepository.getConnectionsData().then((connections) {
      var connection =
          connections.firstWhere((e) => e.connectionName?.isNotEmpty == true);
      var dto = FlutterRequestAriesCredentialChannelDto(
          pairwiseDid: connection.pairwiseDid, sourceId: "flutterVcxDemo");
      return _ariesCredentialRepository
          .acceptCredentialOffer(dto)
          .then((credential) {
        var data = CredentialData(credential.credentialName);
        return _ariesCredentialRepository
            .saveCredentialData(data)
            .then((value) => data);
      });
    });
  }
}
