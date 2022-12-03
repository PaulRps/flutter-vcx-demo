import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/presentation/menu_navigation/proof_page/proof_request_form/proof_request_form.widget.dart';

import 'create_proof_request_screen/create_proof_request_screen.widget.dart';

class ProofPageWidget extends StatefulWidget {
  const ProofPageWidget({Key? key}) : super(key: key);

  @override
  State<ProofPageWidget> createState() => _ProofPageWidgetState();
}

class _ProofPageWidgetState extends State<ProofPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            trailing: const SizedBox.shrink(),
            title: const Text("Prover"),
            children: [ProofRequestFormWidget()],
          ),
          Container(height: 40.0),
          ExpansionTile(
            initiallyExpanded: true,
            trailing: const SizedBox.shrink(),
            title: const Text("Verifier"),
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
                                      CreateProofRequestScreenWidget()));
                        },
                        child: const Text('Create Proof Request')),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
