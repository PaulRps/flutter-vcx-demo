import 'package:flutter_vcx_demo/src/data/dtos/flutter_request_aries_credential_channel.dto.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_connection.repository.dart';
import 'package:flutter_vcx_demo/src/data/repositories/aries_credential.repository.dart';
import 'package:flutter_vcx_demo/src/domain/entities/credential_data.dart';

class AcceptCredentialOfferUsecase {
  late final AriesCredentialRepository _ariesCredentialRepository;
  late final AriesConnectionRepository _ariesConnectionRepository;

  AcceptCredentialOfferUsecase(
      {ariesCredentialRepository, ariesConnectionRepository})
      : _ariesCredentialRepository =
            ariesCredentialRepository ?? AriesCredentialRepository(),
        _ariesConnectionRepository =
            ariesConnectionRepository ?? AriesConnectionRepository();

  Future<CredentialData> acceptOffer() {
    return _ariesConnectionRepository.getConnectionData().then((connection) {
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
