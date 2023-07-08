import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/wallet/ui/widgets/wallet_form.widget.dart';


class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            trailing: const SizedBox.shrink(),
            title: const Text("Wallet"),
            children: [WalletFormWidget()],
          )
        ],
      ),
    );
  }
}
