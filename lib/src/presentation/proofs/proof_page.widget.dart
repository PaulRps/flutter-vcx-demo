import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/commons/extensions/build_context.extension.dart';
import 'package:flutter_vcx_demo/src/presentation/proofs/bloc/proof_page.cubit.dart';
import 'package:flutter_vcx_demo/src/presentation/proofs/bloc/proof_page.state.dart';
import 'package:flutter_vcx_demo/src/presentation/proofs/proof_request_form/proof_request_form.widget.dart';

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
            children: [
              BlocProvider(
                  create: (ctx) => context.bloc<ProofPageCubit>(),
                  child: const ProofRequestFormWidget()),
              BlocListener<ProofPageCubit, ProofPageState>(
                  listener: (ctx, state) {
                state.whenOrNull(
                    presentedProofRequest: () =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Finished present proof successfully')),
                        ),
                    rejectedProofRequest: () =>
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Finished reject proof successfully')),
                        ),
                    error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $msg')),
                        ));
              })
            ],
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
                                  builder: (context) => BlocProvider(
                                      create: (ctx) =>
                                          context.bloc<ProofPageCubit>(),
                                      child:
                                          CreateProofRequestScreenWidget())));
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
