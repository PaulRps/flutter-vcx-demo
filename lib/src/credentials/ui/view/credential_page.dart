import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/core/extensions/build_context.extension.dart';
import 'package:flutter_vcx_demo/src/credentials/ui/widgets/widgets.dart';
import 'package:flutter_vcx_demo/src/credentials/ui/bloc/bloc.dart';

class CredentialPage extends StatefulWidget {
  const CredentialPage({Key? key}) : super(key: key);

  @override
  State<CredentialPage> createState() => _CredentialPageState();
}

class _CredentialPageState extends State<CredentialPage> {
  List<Widget> _credentials = [];

  @override
  void initState() {
    context.bloc<CredentialPageCubit>().getIssuedCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              trailing: SizedBox.shrink(),
              title: Text("Holder"),
              children: [AcceptCredentialOfferFormWidget()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              trailing: const SizedBox.shrink(),
              title: const Text("My Credentials"),
              children: [
                BlocConsumer<CredentialPageCubit, CredentialPageState>(
                    builder: (ctx, state) {
                  _credentials.addAll(state.maybeWhen(
                      getIssuedCredentials: (credentials) =>
                          _buildCredentialsChipWidget(credentials),
                      offerAccepted: (credName) =>
                          [_buildOneCredential(credName)],
                      orElse: () => []));

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _credentials,
                  );
                }, listener: (ctx, state) {
                  state.whenOrNull(
                      error: (msg) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Credential error: $msg')),
                          ),
                      offerAccepted: (name) =>
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Accepted aries credential offer (success=${name.isNotEmpty})')),
                          ));
                }),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCredentialsChipWidget(List<String> data) {
    return data.map((e) => _buildOneCredential(e)).toList();
  }

  Widget _buildOneCredential(String cred) {
    return Expanded(
        flex: 0,
        child: Chip(
            backgroundColor: Colors.green,
            label: Text(
              cred,
              textAlign: TextAlign.start,
            )));
  }
}
