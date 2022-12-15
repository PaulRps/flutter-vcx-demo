import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/commons/extensions/build_context.extension.dart';

import 'cubit/menu_navigation.cubit.dart';

class BottomMenuNavigationWidget extends StatefulWidget {
  const BottomMenuNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomMenuNavigationWidget> createState() =>
      _BottomMenuNavigationWidgetState();
}

class _BottomMenuNavigationWidgetState
    extends State<BottomMenuNavigationWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (int index) {
        // context.bloc<WalletPageCubit>().test();
        context.bloc<MenuNavigationCubit>().navigateTo(index);
        setState(() {
          _selectedIndex = index;
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
}
