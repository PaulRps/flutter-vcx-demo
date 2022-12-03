import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/presentation/menu_navigation/proof_page/proof_page.widget.dart';
import 'package:flutter_vcx_demo/src/presentation/menu_navigation/wallet_page/wallet_page.widget.dart';

import 'connection_page/connection_page.widget.dart';
import 'credential_page/credential_page.widget.dart';

class BottomMenuNavigationWidget extends StatefulWidget {
  const BottomMenuNavigationWidget({Key? key, chosenMenuCb})
      : _chosenMenuCb = chosenMenuCb,
        super(key: key);

  final Function(Widget?) _chosenMenuCb;

  @override
  State<BottomMenuNavigationWidget> createState() =>
      _BottomMenuNavigationWidgetState();
}

Map<int, Widget> menuMap = {
  0: const WalletPageWidget(),
  1: ConnectionPageWidget(),
  2: CredentialPageWidget(),
  3: const ProofPageWidget()
};

class _BottomMenuNavigationWidgetState
    extends State<BottomMenuNavigationWidget> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _navigateToMenu(_selectedIndex));
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
          _navigateToMenu(index);
        });
      },
      selectedFontSize: 14,
      selectedIconTheme: const IconThemeData(color: Colors.white, size: 40),
      selectedItemColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      backgroundColor: Colors.blue,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_wallet),
          label: 'Wallet',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.private_connectivity),
          label: 'Connection',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attribution),
          label: 'Credential',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.domain_verification),
          label: 'Proof',
        ),
      ],
    );
  }

  void _navigateToMenu(int index) {
    var menuItem = menuMap[index];
    widget._chosenMenuCb.call(menuItem!);
  }
}
