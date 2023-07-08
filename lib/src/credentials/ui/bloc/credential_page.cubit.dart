import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/holder_accept_credential_offer.usecase.dart';
import '../../domain/usecases/holder_get_issued_credentials.usecase.dart';
import 'credential_page.state.dart';

@Injectable()
class CredentialPageCubit extends Cubit<CredentialPageState> {
  CredentialPageCubit(this._getIssuedAriesCredentialsUseCase,
      this._acceptCredentialOfferUseCase)
      : super(const CredentialPageState.initial());

  late final HolderGetIssuedCredentialsUseCase
      _getIssuedAriesCredentialsUseCase;
  late final HolderAcceptCredentialOfferUseCase _acceptCredentialOfferUseCase;

  void getIssuedCredentials() {
    try {
      _getIssuedAriesCredentialsUseCase
          .getCredentialsFromStorage()
          .then((value) {
        emit(CredentialPageState.getIssuedCredentials(
            credentialNames: value.map((e) => e.name).toList()));
      }).catchError((error) {
        emit(CredentialPageState.error(message: error.toString()));
      });
    } catch (e) {
      emit(CredentialPageState.error(message: e.toString()));
    }
  }

  void acceptCredentialOffer() {
    try {
      _acceptCredentialOfferUseCase.acceptOffer().then((value) {
        emit(CredentialPageState.offerAccepted(credentialName: value.name));
      }).catchError((error) {
        emit(CredentialPageState.error(message: error.toString()));
      });
    } catch (e) {
      emit(CredentialPageState.error(message: e.toString()));
    }
  }
}