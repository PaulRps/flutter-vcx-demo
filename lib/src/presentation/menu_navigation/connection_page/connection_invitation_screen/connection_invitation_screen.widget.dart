import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_invitation_data.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/inviter_create_connection_invitation.usecase.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../domain/use_cases/inviter_check_connection_invitation_accepted.usecase.dart';

class ConnectionInvitationScreenWidget extends StatefulWidget {
  late final InviterCreateConnectionInvitationUseCase _connectionInvitation;
  late final InviterCheckConnectionInvitationAcceptedUseCase
      _checkConnectionInvitationAccepted;

  ConnectionInvitationScreenWidget(
      {Key? key, createInvitationUsedase, inviteAcceptedUsecase})
      : _connectionInvitation = createInvitationUsedase ??
            InviterCreateConnectionInvitationUseCase(),
        _checkConnectionInvitationAccepted = inviteAcceptedUsecase ??
            InviterCheckConnectionInvitationAcceptedUseCase(),
        super(key: key);

  @override
  State createState() => _CreateConnectionInvitation();
}

class _CreateConnectionInvitation
    extends State<ConnectionInvitationScreenWidget> {
  ConnectionInvitationData? _invitationData;
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? _waitInviteSnackBar;
  Timer? _checkInviteTimer;

  @override
  void initState() {
    super.initState();
    widget._connectionInvitation.createInvite().then((value) {
      setState(() {
        _invitationData = value;
      });
      if (value.connectionHandle.isNotEmpty) _startCheckInvitationAccepted();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _waitInviteSnackBar?.close();
    _checkInviteTimer?.cancel();
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
          return Future.value(widget._checkConnectionInvitationAccepted
              .isInvitationAccepted(
                  connectionHandle: _invitationData!.connectionHandle,
                  isToDeleteHandle: true)
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
    _waitInviteSnackBar = ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(hours: 1),
          content: Row(
            children: const <Widget>[
              CircularProgressIndicator(),
              Text("  Waiting the invite to be accepted...")
            ],
          )),
    );
    _checkInviteTimer = Timer.periodic(const Duration(seconds: 15), (timer) {
      widget._checkConnectionInvitationAccepted
          .isInvitationAccepted(
              connectionHandle: _invitationData!.connectionHandle,
              isToDeleteHandle: false)
          .then((connectionData) {
        var wasAccepted = connectionData.pairwiseDid?.isNotEmpty == true;

        if (wasAccepted) {
          _waitInviteSnackBar?.close();
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
