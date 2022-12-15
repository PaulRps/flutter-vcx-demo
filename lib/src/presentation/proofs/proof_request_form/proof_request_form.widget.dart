import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/prover_present_proof_request.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/prover_reject_proof_request.usecase.dart';

class ProofRequestFormWidget extends StatefulWidget {
  ProofRequestFormWidget(
      {Key? key, presentProofRequestUsecase, rejectProofRequestUsecase})
      : _presentProofRequestUsecase =
            presentProofRequestUsecase ?? ProverPresentProofRequestUseCase(),
        _rejectProofRequestUsecase =
            rejectProofRequestUsecase ?? ProverRejectProofRequestUseCase(),
        super(key: key);

  late final ProverPresentProofRequestUseCase _presentProofRequestUsecase;
  late final ProverRejectProofRequestUseCase _rejectProofRequestUsecase;

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
        ])
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
}
