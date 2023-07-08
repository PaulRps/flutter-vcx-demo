import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/core/core.dart';
import 'package:flutter_vcx_demo/src/proofs/ui/bloc/bloc.dart';
import 'package:flutter_vcx_demo/src/proofs/ui/widgets/widgets.dart';

class ProofPage extends StatefulWidget {
  const ProofPage({Key? key}) : super(key: key);

  @override
  State<ProofPage> createState() => _ProofPageState();
}

class _ProofPageState extends State<ProofPage> {
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
                  child: BlocListener<ProofPageCubit, ProofPageState>(
                      child: const ProofRequestFormWidget(),
                      listener: (ctx, state) {
                        state.whenOrNull(
                            presentedProofRequest: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Finished present proof successfully')),
                                ),
                            rejectedProofRequest: () =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Finished reject proof successfully')),
                                ),
                            error: (msg) =>
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: $msg')),
                                ));
                      })),
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
                                          const CreateProofRequestScreenWidget())));
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
