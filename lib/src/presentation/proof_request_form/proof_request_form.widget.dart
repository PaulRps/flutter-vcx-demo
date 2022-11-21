import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/prover_present_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/prover_reject_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/verifier_send_proof_request.usecase.dart';

import '../../data/dtos/aries_send_proof_response.dto.dart';

class ProofRequestFormWidget extends StatefulWidget {
  ProofRequestFormWidget(
      {Key? key,
      presentProofRequestUsecase,
      rejectProofRequestUsecase,
      sendProofRequest})
      : _presentProofRequestUsecase =
            presentProofRequestUsecase ?? ProverPresentProofRequestUseCase(),
        _rejectProofRequestUsecase =
            rejectProofRequestUsecase ?? ProverRejectProofRequestUseCase(),
        _sendProofRequest = sendProofRequest ?? VerifierSendProofRequestUseCase(),
        super(key: key);

  late final ProverPresentProofRequestUseCase _presentProofRequestUsecase;
  late final ProverRejectProofRequestUseCase _rejectProofRequestUsecase;
  late final VerifierSendProofRequestUseCase _sendProofRequest;

  @override
  State<StatefulWidget> createState() => _PresentProofRequestFormWidget();
}

class _PresentProofRequestFormWidget extends State<ProofRequestFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Row(children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  _presentProof(context);
                },
                child: const Text('Present Proof')),
          ),
          Container(width: 10.0),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  _rejectProof(context);
                },
                child: const Text('Reject Proof')),
          )
        ]),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    _sendRequest(context);
                  },
                  child: const Text('Send Proof Request')),
            )
          ],
        )
      ],
    ));
  }

  void _presentProof(BuildContext context) {
    widget._presentProofRequestUsecase.presentProof().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Finished present proof (success=$value)')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    });
  }

  void _rejectProof(BuildContext context) {
    widget._rejectProofRequestUsecase.reject().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Finished reject proof (success=$value)')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    });
  }

  Future<void> _sendRequest(BuildContext context) async {
    var showSnackBar = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(hours: 1),
          content: Row(
            children: const <Widget>[
              CircularProgressIndicator(),
              Text("  Waiting the proof request to be presented...")
            ],
          )),
    );

    widget._sendProofRequest.sendRequest().then((value) {
      showSnackBar.close();
      _showProofDataDialog(value);
    }).catchError((error, stack) {
      showSnackBar.close();
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

  Future<void> _showProofDataDialog(AriesSendProofResponseDto data) {
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
