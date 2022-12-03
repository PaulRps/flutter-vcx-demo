import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/holder_accept_credential_offer.usecase.dart';

class AcceptCredentialOfferFormWidget extends StatefulWidget {
  late final HolderAcceptCredentialOfferUseCase _acceptCredentialOfferUseCase;

  AcceptCredentialOfferFormWidget(
      {Key? key,
      acceptCredentialOfferUsecase,
      getIssuedAriesCredentialsUseCase})
      : _acceptCredentialOfferUseCase = acceptCredentialOfferUsecase ??
            HolderAcceptCredentialOfferUseCase(),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _AcceptCredentialOfferFormWidget();
}

class _AcceptCredentialOfferFormWidget
    extends State<AcceptCredentialOfferFormWidget> {
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
      ],
    ));
  }

  void _acceptOffer(BuildContext context) {
    widget._acceptCredentialOfferUseCase.acceptOffer().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Finished accept aries credential offer (success=${value.name.isNotEmpty})')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$error')),
      );
    });
  }
}
