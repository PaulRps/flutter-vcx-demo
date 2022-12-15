abstract class WalletPageState {
  String? walletKey;

  String? walletName;

  bool isWalletOpened = false;

  WalletPageState(
      {this.walletKey, this.walletName, required this.isWalletOpened});
}

class WalletInitialState extends WalletPageState {
  WalletInitialState()
      : super(walletKey: null, walletName: null, isWalletOpened: false);
}

class RetrieveWalletDataState extends WalletPageState {
  RetrieveWalletDataState({walletKey, walletName})
      : super(
            walletKey: walletKey,
            walletName: walletName,
            isWalletOpened: false);
}

class WalletErrorState extends WalletPageState {
  String? errorMessage;

  WalletErrorState({walletKey, walletName, this.errorMessage})
      : super(
            walletKey: walletKey,
            walletName: walletName,
            isWalletOpened: false);
}

class WalletAlreadyOpenedState extends WalletPageState {
  WalletAlreadyOpenedState({walletKey, walletName})
      : super(
            walletKey: walletKey, walletName: walletName, isWalletOpened: true);
}

class WalletAreNotOpenedState extends WalletPageState {
  WalletAreNotOpenedState({walletKey, walletName})
      : super(
            walletKey: walletKey,
            walletName: walletName,
            isWalletOpened: false);
}

class WalletOpenedState extends WalletPageState {
  WalletOpenedState({walletKey, walletName})
      : super(
            walletKey: walletKey, walletName: walletName, isWalletOpened: true);
}

class WalletClosedState extends WalletPageState {
  WalletClosedState({walletKey, walletName})
      : super(
            walletKey: walletKey,
            walletName: walletName,
            isWalletOpened: false);
}

class WalletDeletedState extends WalletPageState {
  WalletDeletedState({walletKey, walletName})
      : super(
            walletKey: walletKey,
            walletName: walletName,
            isWalletOpened: false);
}
