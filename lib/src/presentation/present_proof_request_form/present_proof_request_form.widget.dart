import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/present_proof_request.usecase.dart';

class PresentProofRequestFormWidget extends StatefulWidget {
  PresentProofRequestFormWidget({Key? key, presentProofRequestUsecase})
      : _presentProofRequestUsecase =
            presentProofRequestUsecase ?? PresentProofRequestUsecase(),
        super(key: key);

  late final PresentProofRequestUsecase _presentProofRequestUsecase;

  @override
  State<StatefulWidget> createState() => _PresentProofRequestFormWidget();
}

class _PresentProofRequestFormWidget
    extends State<PresentProofRequestFormWidget> {
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
      )
    ]));
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
}
