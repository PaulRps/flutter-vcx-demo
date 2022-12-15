import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_invitation_data.dart';
import 'package:flutter_vcx_demo/src/domain/use_cases/inviter_create_connection_invitation.usecase.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../domain/use_cases/inviter_check_connection_invitation_accepted.usecase.dart';


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
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      _waitInviteSnackBar;
  Timer? _checkInviteTimer;

  @override
  void dispose() {
    super.dispose();
    _waitInviteSnackBar?.close();
    _checkInviteTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              FutureBuilder(
                  builder: (ctx, snapshot) {
                    Widget wdget = const CircularProgressIndicator();
                    if (snapshot.hasError) {
                      wdget = Text(
                        'error ${snapshot.error} occurred on creating connection invitation',
                        style: const TextStyle(fontSize: 18),
                      );
                    } else if (snapshot.hasData) {
                      wdget = QrImage(
                        data: (snapshot.data as ConnectionInvitationData)
                            .inviteUrl,
                        version: QrVersions.auto,
                        size: 300.0,
                      );
                    }

                    return Center(child: wdget);
                  },
                  future:
                      widget._connectionInvitation.createInvite().then((value) {
                    _startCheckInvitationAccepted(value);
                    return value;
                  }))
            ],
          ),
        ));
  }

  void _startCheckInvitationAccepted(ConnectionInvitationData data) {
    _invitationData = data;
    if (_invitationData!.connectionHandle.isNotEmpty) {
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
}
