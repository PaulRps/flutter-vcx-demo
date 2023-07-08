import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/connections/ui/bloc/bloc.dart';
import 'package:flutter_vcx_demo/src/connections/ui/widgets/widgets.dart';
import 'package:flutter_vcx_demo/src/core/extensions/build_context.extension.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final List<Widget> _connections = [];

  @override
  void initState() {
    context.bloc<ConnectionPageCubit>().getConnectionsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: ExpansionTile(
                initiallyExpanded: true,
                trailing: SizedBox.shrink(),
                title: Text("Invitee"),
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
                              _goToInviteScreen(context);
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
                  BlocConsumer<ConnectionPageCubit, ConnectionPageState>(
                      builder: (ctx, state) {
                    _connections.addAll(state.maybeWhen(
                        acceptedConnectionInvitation: (name) =>
                            [_buildOneConnectionChip(name)],
                        inviterCreatedConnection: (name, handle) =>
                            [_buildOneConnectionChip(name)],
                        getConnectionsData: (connections) =>
                            _buildConnectionsChipWidget(connections),
                        orElse: () => []));

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: _connections,
                    );
                  }, listener: (ctx, state) {
                    state.whenOrNull(
                        error: (msg) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Connection Error: $msg'),
                                  duration: const Duration(seconds: 10)),
                            ),
                        acceptedConnectionInvitation: (name) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Created Aries connection (success=${name.isNotEmpty})'),
                                  duration: const Duration(seconds: 10)),
                            ),
                        inviterCreatedConnection: (name, handle) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Created Aries connection (success=${name.isNotEmpty})'),
                                  duration: const Duration(seconds: 10)),
                            ));
                  })
                ],
              ))
        ],
      ),
    );
  }

  void _goToInviteScreen(BuildContext context) {
    var bloc = context.bloc<ConnectionPageCubit>();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (_) => bloc,
                child: const ConnectionInvitationScreenWidget())));
  }

  List<Widget> _buildConnectionsChipWidget(List<String> data) {
    return data.map((e) => _buildOneConnectionChip(e)).toList();
  }

  Widget _buildOneConnectionChip(String name) {
    return Expanded(
        flex: 0,
        child: Chip(
            backgroundColor: Colors.green,
            label: Text(
              name,
              textAlign: TextAlign.start,
            )));
  }
}
