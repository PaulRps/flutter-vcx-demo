import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_page.state.freezed.dart';

@freezed
abstract class WalletPageState with _$WalletPageState {
  const factory WalletPageState.initial(
      {@Default("") String walletKey,
      @Default("") String walletName,
      @Default(false) bool isWalletOpened}) = WalletInitial;

  const factory WalletPageState.error(
      {@Default("") String walletKey,
      @Default("") String walletName,
      @Default(false) bool isWalletOpened,
      required String errorMessage}) = WalletError;

  const factory WalletPageState.retrievedWalletData(
      {required String walletKey,
      required String walletName,
      @Default(false) bool isWalletOpened}) = RetrievedWalletData;

  const factory WalletPageState.walletAlreadyOpened(
      {required String walletKey,
      required String walletName,
      @Default(true) bool isWalletOpened}) = WalletAlreadyOpened;

  const factory WalletPageState.walletAreNotOpened(
      {@Default("") String walletKey,
      @Default("") String walletName,
      @Default(false) bool isWalletOpened}) = WalletAreNotOpened;

  const factory WalletPageState.walletOpened(
      {@Default("") String walletKey,
      @Default("") String walletName,
      @Default(true) bool isWalletOpened}) = WalletOpened;

  const factory WalletPageState.walletClosed(
      {@Default("") String walletKey,
      @Default("") String walletName,
      @Default(false) bool isWalletOpened}) = WalletClosed;

  const factory WalletPageState.walletDeleted(
      {@Default("") String walletKey,
      @Default("") String walletName,
      @Default(false) bool isWalletOpened}) = WalletDeleted;
}
