import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/core/extensions/build_context.extension.dart';

import '../bloc/credential_page.cubit.dart';

class AcceptCredentialOfferFormWidget extends StatefulWidget {
  const AcceptCredentialOfferFormWidget({Key? key}) : super(key: key);

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
                  context.bloc<CredentialPageCubit>().acceptCredentialOffer();
                },
                child: const Text('Accept Credential Offer')),
          )
        ]),
      ],
    ));
  }
}
