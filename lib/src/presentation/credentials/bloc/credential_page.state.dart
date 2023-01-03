import 'package:freezed_annotation/freezed_annotation.dart';

part 'credential_page.state.freezed.dart';

@freezed
abstract class CredentialPageState with _$CredentialPageState {
  const factory CredentialPageState.initial() = CredentialInitial;

  const factory CredentialPageState.error({required String message}) =
      CredentialError;

  const factory CredentialPageState.getIssuedCredentials(
      {required List<String> credentialNames}) = CredentialGetIssued;

  const factory CredentialPageState.offerAccepted(
      {required String credentialName}) = CredentialOfferAccepted;


}
