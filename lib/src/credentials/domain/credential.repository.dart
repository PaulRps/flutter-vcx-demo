import 'entities/entities.dart';

abstract class ICredentialRepository {
  Future<Credential> acceptCredentialOffer(
      {required String pairwiseDid, required String sourceId});

  Future<List<Credential>> getCredentials();

  Future<List<Credential>> getCredentialsData();

  Future<void> saveCredentialData(Credential data);

  Future<bool> deleteCredentialsData();
}
