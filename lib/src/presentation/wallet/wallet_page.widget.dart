import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/presentation/wallet/cubit/wallet_page.cubit.dart';
import 'package:flutter_vcx_demo/src/presentation/wallet/wallet_form/wallet_form.widget.dart';

class WalletPageWidget extends StatefulWidget {
  const WalletPageWidget({Key? key}) : super(key: key);

  @override
  State<WalletPageWidget> createState() => _WalletPageWidgetState();
}

class _WalletPageWidgetState extends State<WalletPageWidget> {
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
            children: [
              BlocProvider<WalletPageCubit>(
                  create: (ctx) => WalletPageCubit(), child: WalletFormWidget())
            ],
          )
        ],
      ),
    );
  }
}
