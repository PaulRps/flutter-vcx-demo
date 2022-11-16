import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_invitation_data.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/create_connection_invitation.usecase.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../domain/use_cases/check_connection_invitation_accepted.usecase.dart';

class ConnectionInvitationScreenWidget extends StatefulWidget {
  late final CreateConnectionInvitationUseCase _connectionInvitation;
  late final CheckConnectionInvitationAcceptedUseCase
      _checkConnectionInvitationAccepted;

  ConnectionInvitationScreenWidget(
      {Key? key, createInvitationUsedase, inviteAcceptedUsecase})
      : _connectionInvitation =
            createInvitationUsedase ?? CreateConnectionInvitationUseCase(),
        _checkConnectionInvitationAccepted =
            inviteAcceptedUsecase ?? CheckConnectionInvitationAcceptedUseCase(),
        super(key: key);

  @override
  State createState() => _CreateConnectionInvitation();
}

class _CreateConnectionInvitation
    extends State<ConnectionInvitationScreenWidget> {
  ConnectionInvitationData? _invitationData;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _waitInvite;

  @override
  void initState() {
    widget._connectionInvitation.createInvite().then((value) {
      setState(() {
        _invitationData = value;
      });
      if (value.connectionHandle.isNotEmpty) _startCheckInvitationAccepted();
    });
  }

  @override
  Widget build(BuildContext context) {
    var widgt = _invitationData != null
        ? QrImage(
            data: _invitationData!.inviteUrl,
            version: QrVersions.auto,
            size: 300.0,
          )
        : const CircularProgressIndicator();
    return WillPopScope(
        onWillPop: () {
          _waitInvite?.close();
          return Future.value(widget._checkConnectionInvitationAccepted
              .isInvitationAccepted(_invitationData!.connectionHandle, true)
              .then((value) => true));
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Connection Invitation'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Center(child: widgt)],
          ),
        ));
  }

  void _startCheckInvitationAccepted() {
    _waitInvite = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(hours: 1),
          content: Row(
            children: const <Widget>[
              CircularProgressIndicator(),
              Text("  Waiting the invite to be accepted...")
            ],
          )),
    );
    Timer.periodic(const Duration(seconds: 10), (timer) {
      widget._checkConnectionInvitationAccepted
          .isInvitationAccepted(_invitationData!.connectionHandle, false)
          .then((connectionData) {
        var wasAccepted = connectionData.pairwiseDid?.isNotEmpty == true;

        if (wasAccepted) {
          _waitInvite?.close();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Connection Created')),
          );
          timer.cancel();
          Navigator.pop(context);
        }
      });
    });
  }
}
