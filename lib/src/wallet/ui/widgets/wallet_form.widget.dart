import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/core/extensions/build_context.extension.dart';

import '../bloc/wallet_page.cubit.dart';
import '../bloc/wallet_page.state.dart';

class WalletFormWidget extends StatefulWidget {
  WalletFormWidget({Key? key}) : super(key: key);

  final TextEditingController _walletNameController = TextEditingController();

  final TextEditingController _walletKeyController = TextEditingController();

  @override
  State<WalletFormWidget> createState() => _WalletFormWidgetState();
}

class _WalletFormWidgetState extends State<WalletFormWidget> {
  @override
  void initState() {
    context.bloc<WalletPageCubit>().retrieveWalletData().then((value) {
      widget._walletKeyController.text = value.key;
      widget._walletNameController.text = value.name;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: BlocConsumer<WalletPageCubit, WalletPageState>(
            builder: (ctx, state) => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Wallet name'),
                          maxLength: 25,
                          controller: widget._walletNameController,
                          keyboardType: TextInputType.text,
                        )),
                        Container(width: 20.0),
                        Expanded(
                            child: TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Wallet key'),
                          keyboardType: TextInputType.number,
                          maxLength: 8,
                          controller: widget._walletKeyController,
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please enter wallet key'
                              : null,
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  ctx.bloc<WalletPageCubit>().openWallet(
                                      name: widget
                                          ._walletNameController.value.text,
                                      key: widget
                                          ._walletKeyController.value.text);
                                },
                                child: const Text('Open'))),
                        Container(width: 10.0),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  ctx.bloc<WalletPageCubit>().closeWallet();
                                },
                                child: const Text('Close'))),
                        Container(width: 10.0),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  ctx.bloc<WalletPageCubit>().deleteWallet();
                                },
                                child: const Text('Delete'))),
                      ],
                    )
                  ],
                ),
            listener: (ctx, state) => _stateHandler(ctx, state)));
  }

  void _stateHandler(ctx, WalletPageState state) {
    state.whenOrNull(
        error: (k, n, i, msg) => ScaffoldMessenger.of(ctx).showSnackBar(
              SnackBar(content: Text(msg)),
            ),
        walletAlreadyOpened: (k, n, i) =>
            ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Wallet has already been opened')),
            ),
        walletAreNotOpened: (k, n, i) => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Wallet has not opened yet')),
            ),
        walletOpened: (k, n, i) => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Wallet has opened successfully')),
            ),
        walletClosed: (k, n, i) => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Wallet has closed successfully')),
            ),
        walletDeleted: (k, n, i) => ScaffoldMessenger.of(ctx).showSnackBar(
              const SnackBar(content: Text('Wallet has deleted successfully')),
            ));
  }
}
