import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/create_aries_connection.usecase.dart';
import 'package:flutter_vcx_demo/src/presentation/connection_invitation_screen/connection_invitation_screen.widget.dart';

import '../../domain/use_cases/retrieve_connection_data.usecase.dart';

class CreateAriesConnectionFormWidget extends StatefulWidget {
  const CreateAriesConnectionFormWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateAriesConnectionFormWidget();
}

class _CreateAriesConnectionFormWidget
    extends State<CreateAriesConnectionFormWidget> {
  final TextEditingController _connectionUrlController =
  TextEditingController();
  final List<Widget> _connections = [];

  late final CreateAriesConnectionUseCase _createAriesConnectionUsecse;
  late final RetrieveConnectionDataUseCase _connectionDataUsecase;

  _CreateAriesConnectionFormWidget(
      {createAriesConnectionUsecse, connectionDataUsecase})
      : _createAriesConnectionUsecse =
      createAriesConnectionUsecse ?? CreateAriesConnectionUseCase(),
        _connectionDataUsecase =
            connectionDataUsecase ?? RetrieveConnectionDataUseCase();

  @override
  void initState() {
    super.initState();
    _connectionDataUsecase
        .getConnectionData()
        .then((value) => _addConnnectionChipWidget(value));
  }

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
                      const InputDecoration(
                          labelText: "Agent's connection URL"),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {
                        // _walletName = value;
                      },
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
                Container(width: 10.0),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  ConnectionInvitationScreenWidget()));
                        },
                        child: const Text('Create Invitation')))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Expanded(
                    child: Text(
                        "Active Connections:", textAlign: TextAlign.start)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _connections,
            )
          ],
        ));
  }

  void _pasteConnectionUrl() {
    Clipboard.getData(Clipboard.kTextPlain)
        .then((value) => _connectionUrlController.text = value?.text ?? "");
  }

  void _createConnection(BuildContext context) {
    _createAriesConnectionUsecse
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
        _addConnnectionChipWidget(connectionData);
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('$error'), duration: const Duration(seconds: 10)),
      );
    });
  }

  void _addConnnectionChipWidget(ConnectionData data) {
    if (data.connectionName != null &&
        data.connectionName?.isNotEmpty == true) {
      setState(() {
        _connections.add(Expanded(
            flex: 0,
            child: Chip(
                backgroundColor: Colors.green,
                label: Text(
                  data.connectionName!,
                  textAlign: TextAlign.start,
                ))));
      });
    }
  }
}
