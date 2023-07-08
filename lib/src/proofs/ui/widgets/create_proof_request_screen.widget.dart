import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/connections/connections.dart';
import 'package:flutter_vcx_demo/src/core/core.dart';
import 'package:flutter_vcx_demo/src/proofs/domain/domain.dart';
import 'package:flutter_vcx_demo/src/proofs/ui/bloc/bloc.dart';

import 'proof_attribute_form_field.widget.dart';

class CreateProofRequestScreenWidget extends StatefulWidget {
  const CreateProofRequestScreenWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateProofRequestScreen();
}

class _CreateProofRequestScreen extends State<CreateProofRequestScreenWidget> {
  final List<ConnectionData> _connections = [];
  String? _currentConnection;
  final List<ProofAttributeFormFieldWidget> _attributeFormFields = [];
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _waitProof;

  @override
  void initState() {
    context.bloc<ProofPageCubit>().getConnectionsData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _stopProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Proof Request'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            child: Form(
                child: Column(
          children: [
            const Text("Connection"),
            Container(height: 30.0),
            Row(children: [
              BlocBuilder<ProofPageCubit, ProofPageState>(
                  builder: (ctx, state) {
                return state.maybeMap(
                    getConnectionsData: (st) =>
                        _buildConnectionsDropDown(st.connections),
                    orElse: () => _buildDefaultConnectionsDropdown());
              })
            ]),
            Container(height: 30.0),
            const Text("Attributes"),
            Row(children: [
              Expanded(
                  child: IconButton(
                onPressed: () {
                  setState(() {
                    _attributeFormFields.add(ProofAttributeFormFieldWidget());
                  });
                },
                icon: const Icon(Icons.add_circle_outline),
              )),
              Container(width: 10.0),
              Expanded(
                  child: IconButton(
                onPressed: () {
                  if (_attributeFormFields.isNotEmpty) {
                    setState(() {
                      _attributeFormFields.removeLast();
                    });
                  }
                },
                icon: const Icon(Icons.remove_circle_outline),
              ))
            ]),
            ..._attributeFormFields
          ],
        ))),
      ),
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: () {
              _sendRequest(context);
            },
            child: const Text("Send Proof Request"),
          )),
    );
  }

  Widget _buildConnectionsDropDown(List<ConnectionData> connections) {
    List<DropdownMenuItem<String?>> connsMenu = [
      const DropdownMenuItem<String?>(
        value: null,
        child: Text("Select a connection"),
      )
    ];

    for (var e in connections) {
      if (e.pairwiseDid != null && e.pairwiseDid?.isNotEmpty == true) {
        // conns.add(e);
        connsMenu.add(DropdownMenuItem<String?>(
          value: e.connectionName?.isEmpty == true &&
                  e.pairwiseDid?.isNotEmpty == true
              ? "invitee"
              : e.connectionName!,
          child: Text(e.connectionName?.isEmpty == true
              ? "Invitee"
              : e.connectionName!),
        ));
      }
    }

    // if (conns.isNotEmpty) {
    //   setState(() {
    //     _connections.addAll(conns);
    //     _connectionsMenuItem.addAll(connsMenu);
    //   });
    // }

    return Expanded(
        child: DropdownButtonFormField<String?>(
            value: _currentConnection,
            onChanged: (String? newValue) {
              setState(() {
                _currentConnection = newValue;
              });
            },
            items: connsMenu));
  }

  Widget _buildDefaultConnectionsDropdown() {
    return Expanded(
        child: DropdownButtonFormField<String?>(
            value: _currentConnection,
            onChanged: (String? newValue) {
              setState(() {
                _currentConnection = newValue;
              });
            },
            items: const [
          DropdownMenuItem<String?>(
            value: null,
            child: Text("Select a connection"),
          )
        ]));
  }

  Future<void> _sendRequest(BuildContext context) async {
    if (!_isProofDataOk()) {
      return Future.value();
    }

    var requestedAttributes = _mapRequestedAttributes();
    var connectionData = _filterConnection();

    _startProgressIndicator();

    context.bloc<ProofPageCubit>().sendProofRequest(
        pairwiseDid: connectionData.pairwiseDid ?? "",
        requestedAttributes: requestedAttributes);
  }

  bool _isProofDataOk() {
    if (_currentConnection == null || _currentConnection?.isEmpty == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must select a connection')),
      );
      return false;
    }

    var invalidAttributes = _attributeFormFields
        .where((e) =>
            e.currentAttribute == null ||
            e.currentAttribute?.isEmpty == true ||
            e.currentSchema == null ||
            e.currentSchema?.isEmpty == true)
        .toList();

    if (invalidAttributes.isNotEmpty || _attributeFormFields.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('One or more attributes need to be set')),
      );
      return false;
    }

    return true;
  }

  void _startProgressIndicator() {
    _waitProof = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(hours: 1),
          content: Row(
            children: const <Widget>[
              CircularProgressIndicator(),
              Text("  Waiting the proof request to be presented...")
            ],
          )),
    );
  }

  void _stopProgressIndicator() {
    try {
      _waitProof?.close();
    } catch (e, stack) {
      FlutterError.reportError(FlutterErrorDetails(
          exception: e,
          library: 'Flutter Vcx Demo',
          context: ErrorSummary('while stopping progress snack bar'),
          stack: stack));
    }
  }

  ConnectionData _filterConnection() {
    var connectionFilter = _currentConnection?.toLowerCase() == "invitee"
        ? ""
        : _currentConnection;
    return _connections
        .where((e) => e.connectionName == connectionFilter)
        .toList()
        .first;
  }

  List<RequestedAttribute> _mapRequestedAttributes() {
    return _attributeFormFields.map((e) {
      var schema = e.currentSchema!.split(":");

      return RequestedAttribute(
          name: e.currentAttribute!,
          schemaName: schema[0],
          schemaVersion: schema[1]);
    }).toList();
  }

  // Future<void> _showProofDataDialog(
  //     BuildContext context, AriesSendProofResponseDto data) {
  //   List<Widget> proofData = [];
  //
  //   if (data.revealedAttributes?.isNotEmpty == true) {
  //     proofData.add(const Text("Revealed Attributes"));
  //     proofData.add(const Text(""));
  //     for (var e in (data.revealedAttributes ?? {}).entries) {
  //       proofData.add(Text("${e.key}: ${e.value}"));
  //     }
  //     proofData.add(const Text(""));
  //   }
  //
  //   if (data.selfAttestAttributes?.isNotEmpty == true) {
  //     proofData.add(const Text("Self Attested Attributes"));
  //     proofData.add(const Text(""));
  //     for (var e in (data.selfAttestAttributes ?? {}).entries) {
  //       proofData.add(Text("${e.key}: ${e.value}"));
  //     }
  //     proofData.add(const Text(""));
  //   }
  //
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Presented Proof Data'),
  //         content: SingleChildScrollView(
  //           child: ListBody(children: proofData),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Close'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
