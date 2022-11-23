import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/data/dtos/aries_request_proof_attribute.dto.dart';
import 'package:flutter_vcx_demo/src/presentation/create_proof_request_screen/proof_attribute_form_field.widget.dart';

import '../../data/dtos/aries_send_proof_response.dto.dart';
import '../../domain/entities/connection_data.dart';
import '../../domain/use_cases/retrieve_aries_connection_data.usecase.dart';
import '../../domain/use_cases/verifier_send_proof_request.usecase.dart';

class CreateProofRequestScreenWidget extends StatefulWidget {
  CreateProofRequestScreenWidget(
      {Key? key, sendProofRequest, connectionDataUsecase})
      : _sendProofRequest =
            sendProofRequest ?? VerifierSendProofRequestUseCase(),
        _connectionDataUsecase =
            connectionDataUsecase ?? RetrieveAriesConnectionDataUseCase(),
        super(key: key);

  late final VerifierSendProofRequestUseCase _sendProofRequest;
  late final RetrieveAriesConnectionDataUseCase _connectionDataUsecase;

  @override
  State<StatefulWidget> createState() => _CreateProofRequestScreen();
}

class _CreateProofRequestScreen extends State<CreateProofRequestScreenWidget> {
  final List<ConnectionData> _connections = [];
  final List<DropdownMenuItem<String?>> _connectionsMenuItem = [
    const DropdownMenuItem<String?>(
      value: null,
      child: Text("Select a connection"),
    )
  ];
  String? _currentConnection;
  final List<ProofAttributeFormFieldWidget> _attributeFormFields = [];
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _waitProof;

  @override
  void initState() {
    widget._connectionDataUsecase.getConnectionData().then((value) {
      setState(() {
        _connections.add(value);
        _connectionsMenuItem.add(DropdownMenuItem<String?>(
          value: value.connectionName?.isEmpty == true &&
                  value.pairwiseDid?.isNotEmpty == true
              ? "invitee"
              : value.connectionName!,
          child: Text(value.connectionName?.isEmpty == true
              ? "Invitee"
              : value.connectionName!),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
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
                  Expanded(
                      child: DropdownButtonFormField<String?>(
                          value: _currentConnection,
                          onChanged: (String? newValue) {
                            setState(() {
                              _currentConnection = newValue;
                            });
                          },
                          items: _connectionsMenuItem))
                ]),
                Container(height: 30.0),
                const Text("Attributes"),
                Row(children: [
                  Expanded(
                      child: IconButton(
                    onPressed: () {
                      setState(() {
                        _attributeFormFields
                            .add(ProofAttributeFormFieldWidget());
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
        ),
        onWillPop: () {
          _stopProgressIndicator();
          return Future.value(true);
        });
  }

  Future<void> _sendRequest(BuildContext context) async {
    if (!_isProofDataOk()) {
      return Future.value();
    }

    var requestedAttributes = _mapRequestedAttributes();
    var connectionData = _filterConnection();

    _startProgressIndicator();

    widget._sendProofRequest
        .sendRequest(
            sourceId: "flutter_vcx_demo",
            pairwiseDid: connectionData.pairwiseDid,
            requestedAttributes: requestedAttributes)
        .then((value) {
      _stopProgressIndicator();
      _showProofDataDialog(context, value);
    }).catchError((error, stack) {
      _stopProgressIndicator();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
      FlutterError.reportError(FlutterErrorDetails(
          exception: error,
          library: 'Flutter Vcx Demo',
          context: ErrorSummary('while running async send proof request'),
          stack: stack));
    });
  }

  bool _isProofDataOk() {
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

    if (_currentConnection == null || _currentConnection?.isEmpty == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must select a connection')),
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
    } catch (e) {}
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

  List<AriesRequestedProofAttributeDto> _mapRequestedAttributes() {
    return _attributeFormFields.map((e) {
      var schema = e.currentSchema!.split(":");

      return AriesRequestedProofAttributeDto(
          name: e.currentAttribute!,
          schemaName: schema[0],
          schemaVersion: schema[1]);
    }).toList();
  }

  Future<void> _showProofDataDialog(
      BuildContext context, AriesSendProofResponseDto data) {
    List<Widget> proofData = [];

    if (data.revealedAttributes?.isNotEmpty == true) {
      proofData.add(const Text("Revealed Attributes"));
      proofData.add(const Text(""));
      data.revealedAttributes?.entries
          .forEach((e) => proofData.add(Text("${e.key}: ${e.value}")));
      proofData.add(const Text(""));
    }

    if (data.selfAttestAttributes?.isNotEmpty == true) {
      proofData.add(const Text("Self Attested Attributes"));
      proofData.add(const Text(""));
      data.selfAttestAttributes?.entries
          .forEach((e) => proofData.add(Text("${e.key}: ${e.value}")));
      proofData.add(const Text(""));
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Presented Proof Data'),
          content: SingleChildScrollView(
            child: ListBody(children: proofData),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
