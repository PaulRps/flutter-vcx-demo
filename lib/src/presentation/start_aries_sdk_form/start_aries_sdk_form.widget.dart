import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/retrieve_aries_wallet_data.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/shutdown_or_reset_aries_sdk.usercase.dart';

import '../../domain/entities/wallet_data.dart';
import '../../domain/use_cases/start_aries_sdk_and_save_wallet_data.usecase.dart';

class StartAriesSdkFormWidget extends StatelessWidget {
  String? _walletKey;
  String? _walletName;
  bool _isSdkStarted = false;

  final StartAriesSdkAndSaveWalletDataUseCase _startAriesSdkUseCase =
      StartAriesSdkAndSaveWalletDataUseCase();
  final RetrieveAriesWalletDataUseCase _retrieveWalletDataUseCase =
      RetrieveAriesWalletDataUseCase();
  final ShutdownOrResetAriesSdkUseCase _shutdownOrResetAriesSdkUsecase =
      ShutdownOrResetAriesSdkUseCase();

  final TextEditingController _walletNameController = TextEditingController();
  final TextEditingController _walletKeyController = TextEditingController();

  StartAriesSdkFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _retrieveWalletDataUseCase.retrieveWalletData().then((value) {
      if (value.key.isNotEmpty) {
        _walletKeyController.text = _walletKey = value.key;
      }

      if (value.name.isNotEmpty) {
        _walletNameController.text = _walletName = value.name;
      }
    });
    return Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Wallet name'),
                  maxLength: 25,
                  controller: _walletNameController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    _walletName = value;
                  },
                )),
                Container(width: 20.0),
                Expanded(
                    child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Wallet key'),
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  controller: _walletKeyController,
                  onChanged: (value) {
                    _walletKey = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter wallet key';
                    }
                    return null;
                  },
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _startSdk(context);
                        },
                        child: const Text('Start SDK'))),
                Container(width: 10.0),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _shutdownSdk(context);
                        },
                        child: const Text('Shutdown'))),
                Container(width: 10.0),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          _resetSdk(context);
                        },
                        child: const Text('Reset'))),
              ],
            )
          ],
        ));
  }

  void _startSdk(BuildContext context) {
    if (_isSdkStarted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SDK has already been started')),
      );
      return;
    }

    _startAriesSdkUseCase
        .startSdkAndSaveWalletData(WalletData(
            name: _walletName ?? "flutter_vcx_demo_wallet",
            key: _walletKey ?? ""))
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Finished Aries SDK start (success=$value)')),
      );
      _isSdkStarted = value;
      _walletNameController.text = _walletName ?? "flutter_vcx_demo_wallet";
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    });
  }

  void _shutdownSdk(BuildContext context) {
    if (!_isSdkStarted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SDK has not started yet')),
      );
      return;
    }

    _shutdownOrResetAriesSdkUsecase.shutdownSdk().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Finished Aries SDK shutdown (success=$value)')),
      );
      _isSdkStarted = !value;
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    });
  }

  void _resetSdk(BuildContext context) {
    if (!_isSdkStarted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SDK has not started yet')),
      );
      return;
    }

    _shutdownOrResetAriesSdkUsecase.resetSdk().then((wasReseted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Finished Aries SDK start (success=$wasReseted)')),
      );
      if (wasReseted) {
        _isSdkStarted = false;
        _walletName = _walletKey = null;
        _walletKeyController.text = _walletNameController.text = "";
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    });
  }
}
