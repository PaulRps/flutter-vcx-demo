import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_navigation.state.freezed.dart';

enum MenuItem { wallet, connection, credential, proof }

@freezed
abstract class MenuNavigationState with _$MenuNavigationState {
  const factory MenuNavigationState.wallet(
      {@Default(MenuItem.wallet) MenuItem menuItem}) = WalletMenu;

  const factory MenuNavigationState.connection(
      {@Default(MenuItem.connection) MenuItem menuItem}) = ConnectionMenu;

  const factory MenuNavigationState.credential(
      {@Default(MenuItem.credential) MenuItem menuItem}) = CredentialMenu;

  const factory MenuNavigationState.proof(
      {@Default(MenuItem.proof) MenuItem menuItem}) = ProofMenu;
}
