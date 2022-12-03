import 'package:flutter/material.dart';

import '../../../domain/entities/credential_data.dart';
import '../../../domain/use_cases/holder_get_issued_credentials.usecase.dart';
import 'accept_credential_offer_form/accept_credential_offer_form.widget.dart';

class CredentialPageWidget extends StatefulWidget {
  CredentialPageWidget({Key? key, getIssuedAriesCredentialsUseCase})
      : _getIssuedAriesCredentialsUseCase = getIssuedAriesCredentialsUseCase ??
            HolderGetIssuedCredentialsUseCase(),
        super(key: key);

  late final HolderGetIssuedCredentialsUseCase
      _getIssuedAriesCredentialsUseCase;

  @override
  State<CredentialPageWidget> createState() => _CredentialPageWidgetState();
}

class _CredentialPageWidgetState extends State<CredentialPageWidget> {
  final List<Widget> _credentials = [];

  @override
  void initState() {
    super.initState();
    widget._getIssuedAriesCredentialsUseCase
        .getCredentialsFromStorage()
        .then((credentials) => _addCredentialsChipWidget(credentials));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: ExpansionTile(
              initiallyExpanded: true,
              trailing: const SizedBox.shrink(),
              title: const Text("Holder"),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _credentials,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _addCredentialsChipWidget(List<CredentialData> data) {
    if (data.isNotEmpty) {
      setState(() {
        for (var cred in data) {
          _addOneCredential(cred);
        }
      });
    }
  }

  void _addOneCredential(CredentialData cred) {
    _credentials.add(Expanded(
        flex: 0,
        child: Chip(
            backgroundColor: Colors.green,
            label: Text(
              cred.name,
              textAlign: TextAlign.start,
            ))));
  }
}
