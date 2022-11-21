import 'package:flutter_vcx_demo/src/domain/entities/credential_data.dart';

import '../../data/repositories/aries_credential.repository.dart';

class HolderGetIssuedCredentialsUseCase {
  late final AriesCredentialRepository _ariesCredentialRepository;

  HolderGetIssuedCredentialsUseCase({ariesCredentialRepository})
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
