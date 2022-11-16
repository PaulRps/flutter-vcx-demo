import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/entities/credential_data.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/accept_credential_offer.usecase.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/get_issued_aries_credentials.usecase.dart';

class AcceptCredentialOfferFormWidget extends StatefulWidget {
  late final AcceptCredentialOfferUseCase _acceptCredentialOfferUsecase;
  late final GetIssuedAriesCredentialsUseCase _getIssuedAriesCredentialsUsecase;

  AcceptCredentialOfferFormWidget(
      {Key? key,
      acceptCredentialOfferUsecase,
      getIssuedAriesCredentialsUsecase})
      : _acceptCredentialOfferUsecase =
            acceptCredentialOfferUsecase ?? AcceptCredentialOfferUseCase(),
        _getIssuedAriesCredentialsUsecase = getIssuedAriesCredentialsUsecase ??
            GetIssuedAriesCredentialsUseCase(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _AcceptCredentialOfferFormWidget();
}

class _AcceptCredentialOfferFormWidget
    extends State<AcceptCredentialOfferFormWidget> {
  final List<Widget> _credentials = [];

  @override
  void initState() {
    widget._getIssuedAriesCredentialsUsecase
        .getCredentialsFromStorage()
        .then((credentials) => _addCredentialsChipWidget(credentials));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Wrap(
      children: [
        Row(children: [
          Expanded(
            child: ElevatedButton(
                onPressed: () {
                  _acceptOffer(context);
                },
                child: const Text('Accept Credential Offer')),
          )
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Expanded(
                child: Text("Issued Credentials:", textAlign: TextAlign.start)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: _credentials,
        )
      ],
    ));
  }

  void _acceptOffer(BuildContext context) {
    widget._acceptCredentialOfferUsecase.acceptOffer().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Finished accept aries credential offer (success=${value.name.isNotEmpty})')),
      );

      setState(() {
        _addOneCredential(value);
      });
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    });
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
