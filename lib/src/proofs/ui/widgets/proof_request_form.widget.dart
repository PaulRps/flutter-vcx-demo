import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/core/core.dart';

import '../bloc/proof_page.cubit.dart';

class ProofRequestFormWidget extends StatefulWidget {
  const ProofRequestFormWidget({Key? key}) : super(key: key);

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
                  context.bloc<ProofPageCubit>().presentProof();
                },
                child: const Text('Present Proof')),
          ),
          Container(width: 10.0),
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  context.bloc<ProofPageCubit>().rejectProof();
                },
                child: const Text('Reject Proof')),
          )
        ])
      ],
    ));
  }
}
