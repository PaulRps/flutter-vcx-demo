import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/core/extensions/build_context.extension.dart';

import '../bloc/connection_page.cubit.dart';
import '../bloc/connection_page.state.dart';

class CreateAriesConnectionFormWidget extends StatefulWidget {
  const CreateAriesConnectionFormWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateAriesConnectionFormWidget();
}

class _CreateAriesConnectionFormWidget
    extends State<CreateAriesConnectionFormWidget> {
  final TextEditingController _connectionUrlController =
      TextEditingController();

  _CreateAriesConnectionFormWidget();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Wrap(
      children: [
        Row(
          children: [
            Expanded(
                child: TextFormField(
              controller: _connectionUrlController,
              decoration:
                  const InputDecoration(labelText: "Agent's connection URL"),
              keyboardType: TextInputType.text,
            )),
            GestureDetector(
              child: IconButton(
                icon: const Icon(Icons.content_paste_go_rounded),
                onPressed: () {
                  _pasteConnectionUrl();
                },
              ),
            )
          ],
        ),
        BlocListener<ConnectionPageCubit, ConnectionPageState>(
            listener: (ctx, state) {
              state.whenOrNull(
                  acceptedConnectionInvitation: (name) =>
                      _connectionUrlController.text = "");
            },
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          context
                              .bloc<ConnectionPageCubit>()
                              .inviteeAcceptConnectionInvitation(
                                  connectionUrl: _connectionUrlController.text);
                        },
                        child: const Text('Connect'))),
              ],
            ))
      ],
    ));
  }

  void _pasteConnectionUrl() {
    Clipboard.getData(Clipboard.kTextPlain)
        .then((value) => _connectionUrlController.text = value?.text ?? "");
  }

// void _createConnection(BuildContext context) {
//   context.bloc<ConnectionPageCubit>().inviteeAcceptConnectionInvitation(
//       connectionUrl: _connectionUrlController.text);
// widget._createAriesConnectionUseCase
//     .createConnection(connectionUrl: _connectionUrlController.text)
//     .then((connectionData) {
//   var success = connectionData.pairwiseDid != null &&
//       connectionData.pairwiseDid?.isNotEmpty == true;
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//         content: Text('Created Aries connection (success=$success)'),
//         duration: const Duration(seconds: 10)),
//   );
//   if (success) {
//     _connectionUrlController.text = "";
//   }
// });
// }
}
