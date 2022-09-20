import 'package:flutter_vcx_demo/src/data/dtos/aries_credential.dto.dart';
import 'package:flutter_vcx_demo/src/domain/entities/credential_data.dart';

import '../../data/repositories/aries_credential.repository.dart';

class GetIssuedAriesCredentialsUsecase {
  late final AriesCredentialRepository _ariesCredentialRepository;

  GetIssuedAriesCredentialsUsecase({ariesCredentialRepository})
      : _ariesCredentialRepository =
            ariesCredentialRepository ?? AriesCredentialRepository();

  Future<List<CredentialData>> getCredentials() {
    return _ariesCredentialRepository.getCredentials().then((value) =>
        value.credentials.map((cred) => CredentialData(cred.name)).toList());
  }

  Future<List<CredentialData>> getCredentialsFromStorage() {
    return _ariesCredentialRepository.getCredentialsData();
  }
}
