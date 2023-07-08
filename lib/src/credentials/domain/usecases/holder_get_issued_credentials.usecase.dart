import 'package:flutter_vcx_demo/src/credentials/domain/entities/entities.dart';
import 'package:injectable/injectable.dart';

import '../credential.repository.dart';

@Injectable()
class HolderGetIssuedCredentialsUseCase {
  late final ICredentialRepository _ariesCredentialRepository;

  HolderGetIssuedCredentialsUseCase(this._ariesCredentialRepository);

  Future<List<Credential>> getCredentials() {
    return _ariesCredentialRepository.getCredentials().then((value) =>
        value.map((cred) => Credential(name: cred.name)).toList());
  }

  Future<List<Credential>> getCredentialsFromStorage() {
    return _ariesCredentialRepository.getCredentialsData();
  }
}
