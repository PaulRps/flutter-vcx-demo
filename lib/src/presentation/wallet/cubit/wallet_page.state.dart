import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_page.state.freezed.dart';

abstract class WalletPageState {
  abstract final String? walletKey;

  abstract final String? walletName;

  abstract final bool isWalletOpened;
}

@freezed
class WalletInitialState extends WalletPageState with _$WalletInitialState {
  factory WalletInitialState(
      {String? walletKey,
      String? walletName,
      @Default(false) bool isWalletOpened}) = _WalletInitialState;
}

@freezed
class RetrieveWalletDataState extends WalletPageState
    with _$RetrieveWalletDataState {
  factory RetrieveWalletDataState(
      {required String? walletKey,
      required String? walletName,
      @Default(false) bool isWalletOpened}) = _RetrieveWalletDataState;
}

@freezed
class WalletErrorState extends WalletPageState with _$WalletErrorState {
  factory WalletErrorState(
      {String? walletKey,
      String? walletName,
      required String? errorMessage,
      @Default(false) bool isWalletOpened}) = _WalletErrorState;
}

@freezed
class WalletAlreadyOpenedState extends WalletPageState
    with _$WalletAlreadyOpenedState {
  factory WalletAlreadyOpenedState(
      {String? walletKey,
      String? walletName,
      @Default(true) bool isWalletOpened}) = _WalletAlreadyOpenedState;
}

@freezed
class WalletAreNotOpenedState extends WalletPageState
    with _$WalletAreNotOpenedState {
  factory WalletAreNotOpenedState(
      {String? walletKey,
      String? walletName,
      @Default(false) bool isWalletOpened}) = _WalletAreNotOpenedState;
}

@freezed
class WalletOpenedState extends WalletPageState with _$WalletOpenedState {
  factory WalletOpenedState(
      {String? walletKey,
      String? walletName,
      @Default(true) bool isWalletOpened}) = _WalletOpenedState;
}

@freezed
class WalletClosedState extends WalletPageState with _$WalletClosedState {
  factory WalletClosedState(
      {String? walletKey,
      String? walletName,
      @Default(false) bool isWalletOpened}) = _WalletClosedState;
}

@freezed
class WalletDeletedState extends WalletPageState with _$WalletDeletedState {
  factory WalletDeletedState(
      {String? walletKey,
      String? walletName,
      @Default(false) bool isWalletOpened}) = _WalletDeletedState;
}
