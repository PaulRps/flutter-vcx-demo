import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/commons/extensions/build_context.extension.dart';
import 'package:flutter_vcx_demo/src/presentation/wallet/cubit/wallet_page.state.dart';

import '../cubit/wallet_page.cubit.dart';

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
            builder: (ctx, state) =>
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Wallet name'),
                              maxLength: 25,
                              controller: widget._walletNameController,
                              keyboardType: TextInputType.text,
                            )),
                        Container(width: 20.0),
                        Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  labelText: 'Wallet key'),
                              keyboardType: TextInputType.number,
                              maxLength: 8,
                              controller: widget._walletKeyController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter wallet key';
                                }
                                return null;
                              },
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
                                child: const Text('Open Wallet'))),
                        Container(width: 10.0),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  ctx.bloc<WalletPageCubit>().closeWallet();
                                },
                                child: const Text('Close Wallet'))),
                        Container(width: 10.0),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  ctx.bloc<WalletPageCubit>().deleteWallet();
                                },
                                child: const Text('Delete Wallet'))),
                      ],
                    )
                  ],
                ),
            listener: (ctx, state) => _stateHandler(ctx, state)));
  }

  void _stateHandler(ctx, state) {
    if (state is WalletErrorState) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text('${state.errorMessage}')),
      );
    } else if (state is WalletAlreadyOpenedState) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Wallet has already been opened')),
      );
    } else if (state is WalletAreNotOpenedState) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Wallet has not opened yet')),
      );
    } else if (state is WalletOpenedState) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Wallet has opened successfully')),
      );
    } else if (state is WalletClosedState) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Wallet has closed successfully')),
      );
    } else if (state is WalletDeletedState) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(content: Text('Wallet has deleted successfully')),
      );
    }
  }
}
