import 'package:flutter/material.dart';

import '../../domain/entities/connection_data.dart';
import '../../domain/use_cases/retrieve_aries_connection_data.usecase.dart';
import 'connection_invitation_screen/connection_invitation_screen.widget.dart';
import 'create_aries_connection_form/create_aries_connection_form.widget.dart';

class ConnectionPageWidget extends StatefulWidget {
  ConnectionPageWidget({Key? key, connectionDataUseCase})
      : _connectionDataUseCase =
            connectionDataUseCase ?? RetrieveAriesConnectionDataUseCase(),
        super(key: key);

  late final RetrieveAriesConnectionDataUseCase _connectionDataUseCase;

  @override
  State<ConnectionPageWidget> createState() => _ConnectionPageWidgetState();
}

class _ConnectionPageWidgetState extends State<ConnectionPageWidget> {
  final List<Widget> _connections = [];

  @override
  void initState() {
    super.initState();
    widget._connectionDataUseCase
        .getConnectionsData()
        .then((value) => _addConnnectionChipWidget(value));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: ExpansionTile(
                initiallyExpanded: true,
                trailing: const SizedBox.shrink(),
                title: const Text("Invitee"),
                children: [CreateAriesConnectionFormWidget()],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: ExpansionTile(
                title: const Text("Inviter"),
                initiallyExpanded: true,
                trailing: const SizedBox.shrink(),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ConnectionInvitationScreenWidget()));
                            },
                            child: const Text('Create Invitation')),
                      )
                    ],
                  )
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: ExpansionTile(
                initiallyExpanded: true,
                trailing: const SizedBox.shrink(),
                title: const Text("My Connections"),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _connections,
                  )
                ],
              ))
        ],
      ),
    );
  }

  void _addConnnectionChipWidget(List<ConnectionData> data) {
    if (data.isNotEmpty) {
      setState(() {
        for (var e in data) {
          if (e.connectionName != null &&
              e.connectionName?.isNotEmpty == true) {
            _connections.add(Expanded(
                flex: 0,
                child: Chip(
                    backgroundColor: Colors.green,
                    label: Text(
                      e.connectionName!,
                      textAlign: TextAlign.start,
                    ))));
          }
        }
      });
    }
  }
}
