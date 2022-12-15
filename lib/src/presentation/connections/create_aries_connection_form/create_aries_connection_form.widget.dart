import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/invitee_accept_connection_invitation.usecase.dart';

class CreateAriesConnectionFormWidget extends StatefulWidget {
  CreateAriesConnectionFormWidget({Key? key, createAriesConnectionUsecse})
      : _createAriesConnectionUseCase = createAriesConnectionUsecse ??
            InviteeAcceptConnectionInvitationUseCase(),
        super(key: key);

  late final InviteeAcceptConnectionInvitationUseCase
      _createAriesConnectionUseCase;

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
        Row(
          children: [
            Expanded(
                child: ElevatedButton(
                    onPressed: () {
                      _createConnection(context);
                    },
                    child: const Text('Connect'))),
          ],
        ),
      ],
    ));
  }

  void _pasteConnectionUrl() {
    Clipboard.getData(Clipboard.kTextPlain)
        .then((value) => _connectionUrlController.text = value?.text ?? "");
  }

  void _createConnection(BuildContext context) {
    widget._createAriesConnectionUseCase
        .createConnection(connectionUrl: _connectionUrlController.text)
        .then((connectionData) {
      var success = connectionData.pairwiseDid != null &&
          connectionData.pairwiseDid?.isNotEmpty == true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Created Aries connection (success=$success)'),
            duration: const Duration(seconds: 10)),
      );
      if (success) {
        _connectionUrlController.text = "";
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('$error'), duration: const Duration(seconds: 10)),
      );
    });
  }
}
