enum _MenuItem { wallet, connection, credential, proof }

abstract class MenuNavigationState {
  final _MenuItem menuItem;

  MenuNavigationState(this.menuItem);

}

class WalletMenuState extends MenuNavigationState {
  WalletMenuState() : super(_MenuItem.wallet);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is WalletMenuState && o.menuItem == menuItem;
  }

  @override
  int get hashCode {
    return menuItem.hashCode;
  }
}

class ConnectionMenuState extends MenuNavigationState {
  ConnectionMenuState() : super(_MenuItem.connection);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ConnectionMenuState && o.menuItem == menuItem;
  }

  @override
  int get hashCode {
    return menuItem.hashCode;
  }
}

class CredentialMenuState extends MenuNavigationState {
  CredentialMenuState() : super(_MenuItem.credential);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CredentialMenuState && o.menuItem == menuItem;
  }

  @override
  int get hashCode {
    return menuItem.hashCode;
  }
}

class ProofMenuState extends MenuNavigationState {
  ProofMenuState() : super(_MenuItem.proof);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProofMenuState && o.menuItem == menuItem;
  }

  @override
  int get hashCode {
    return menuItem.hashCode;
  }
}
