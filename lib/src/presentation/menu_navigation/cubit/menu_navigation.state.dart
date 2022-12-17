import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_navigation.state.freezed.dart';

enum MenuItem { wallet, connection, credential, proof }

abstract class MenuNavigationState {
  final MenuItem menuItem;

  MenuNavigationState(this.menuItem);
}

@freezed
class WalletMenuState extends MenuNavigationState with _$WalletMenuState {
  factory WalletMenuState({@Default(MenuItem.wallet) MenuItem menuItem}) =
      _WalletMenuState;
}

@freezed
class ConnectionMenuState extends MenuNavigationState
    with _$ConnectionMenuState {
  factory ConnectionMenuState(
      {@Default(MenuItem.connection) MenuItem menuItem}) = _ConnectionMenuState;
}

@freezed
class CredentialMenuState extends MenuNavigationState with _$CredentialMenuState {

  factory CredentialMenuState(
      {@Default(MenuItem.credential) MenuItem menuItem}) = _CredentialMenuState;
}

@freezed
class ProofMenuState extends MenuNavigationState with _$ProofMenuState {
  factory ProofMenuState(
      {@Default(MenuItem.proof) MenuItem menuItem}) = _ProofMenuState;
}
