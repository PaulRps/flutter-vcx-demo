import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/present_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/reject_proof_request.usecase.dart';

class ProofRequestFormWidget extends StatefulWidget {
  ProofRequestFormWidget(
      {Key? key, presentProofRequestUsecase, rejectProofRequestUsecase})
      : _presentProofRequestUsecase =
            presentProofRequestUsecase ?? PresentProofRequestUsecase(),
        _rejectProofRequestUsecase =
            rejectProofRequestUsecase ?? RejectProofRequestUsecase(),
        super(key: key);

  late final PresentProofRequestUsecase _presentProofRequestUsecase;
  late final RejectProofRequestUsecase _rejectProofRequestUsecase;

  @override
  State<StatefulWidget> createState() => _PresentProofRequestFormWidget();
}

class _PresentProofRequestFormWidget extends State<ProofRequestFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Row(children: [
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
    ]));
  }

  void _presentProof(BuildContext context) {
    widget._presentProofRequestUsecase.present().then((value) {
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
}
