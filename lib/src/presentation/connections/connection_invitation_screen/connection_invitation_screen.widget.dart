import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vcx_demo/src/commons/extensions/build_context.extension.dart';
import 'package:flutter_vcx_demo/src/presentation/connections/bloc/connection_page.cubit.dart';
import 'package:flutter_vcx_demo/src/presentation/connections/bloc/connection_page.state.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ConnectionInvitationScreenWidget extends StatefulWidget {
  const ConnectionInvitationScreenWidget({Key? key}) : super(key: key);

  @override
  State createState() => _CreateConnectionInvitation();
}

class _CreateConnectionInvitation
    extends State<ConnectionInvitationScreenWidget> {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
      _waitInviteSnackBar;
  Timer? _checkInviteTimer;

  @override
  void initState() {
    context.bloc<ConnectionPageCubit>().inviterCreateConnectionInvitation();
    super.initState();
  }

  @override
  void dispose() {
    _waitInviteSnackBar?.close();
    _checkInviteTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connection Invitation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<ConnectionPageCubit, ConnectionPageState>(
              builder: (ctx, state) {
            Widget wdget = state.maybeWhen(
                inviterCreatedConnectionInvitation:
                    (String url, String handle) {
                  return QrImage(
                    data: url,
                    version: QrVersions.auto,
                    size: 300.0,
                  );
                },
                orElse: () => const CircularProgressIndicator());

            return Center(child: wdget);
          }, listener: (ctx, state) {
            state.whenOrNull(
                inviterCreatedConnectionInvitation:
                    (String url, String handle) =>
                        _startCheckInvitationAccepted(handle),
                inviterCreatedConnection: (name, handle) => _finish(handle));
          })
        ],
      ),
    );
  }

  void _startCheckInvitationAccepted(String connectionHandle) {
    if (connectionHandle.isNotEmpty) {
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
        context
            .bloc<ConnectionPageCubit>()
            .inviterCheckInvitationAccepted(connectionHandle: connectionHandle);
      });
    }
  }

  void _finish(String connectionHandle) {
    _waitInviteSnackBar?.close();
    _checkInviteTimer?.cancel();
    context.bloc<ConnectionPageCubit>().inviterCheckInvitationAccepted(
        connectionHandle: connectionHandle, isToDeleteHandle: true);
    Navigator.pop(context);
  }
}
