import 'package:flutter_vcx_demo/src/domain/entities/credential_data.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/aries_credential.repository.dart';

@Injectable()
class HolderGetIssuedCredentialsUseCase {
  late final IAriesCredentialRepository _ariesCredentialRepository;

  HolderGetIssuedCredentialsUseCase(this._ariesCredentialRepository);

  Future<List<CredentialData>> getCredentials() {
    return _ariesCredentialRepository.getCredentials().then((value) =>
        value.credentials.map((cred) => CredentialData(cred.name)).toList());
  }

  Future<List<CredentialData>> getCredentialsFromStorage() {
    return _ariesCredentialRepository.getCredentialsData();
  }
}
