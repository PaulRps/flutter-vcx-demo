import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/present_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/reject_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/send_proof_request.usecase.dart';

class ProofRequestFormWidget extends StatefulWidget {
  ProofRequestFormWidget(
      {Key? key,
      presentProofRequestUsecase,
      rejectProofRequestUsecase,
      sendProofRequest})
      : _presentProofRequestUsecase =
            presentProofRequestUsecase ?? PresentProofRequestUseCase(),
        _rejectProofRequestUsecase =
            rejectProofRequestUsecase ?? RejectProofRequestUseCase(),
        _sendProofRequest = sendProofRequest ?? SendProofRequestUseCase(),
        super(key: key);

  late final PresentProofRequestUseCase _presentProofRequestUsecase;
  late final RejectProofRequestUseCase _rejectProofRequestUsecase;
  late final SendProofRequestUseCase _sendProofRequest;

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

  void _sendRequest(BuildContext context) {
    widget._sendProofRequest.sendRequest().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Finished send proof request (success=$value)')),
      );
    }).catchError((error, stack) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        library: 'Flutter Vcx Demo',
        context: ErrorSummary('while running async send proof request'),
        stack: stack
      ));
    });
  }
}
