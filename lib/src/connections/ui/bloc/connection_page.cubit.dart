import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/invitee_accept_connection_invitation.usecase.dart';
import '../../domain/usecases/inviter_check_connection_invitation_accepted.usecase.dart';
import '../../domain/usecases/inviter_create_connection_invitation.usecase.dart';
import '../../domain/usecases/retrieve_aries_connection_data.usecase.dart';
import 'connection_page.state.dart';

@Injectable()
class ConnectionPageCubit extends Cubit<ConnectionPageState> {
  ConnectionPageCubit(
      this._connectionDataUseCase,
      this._createAriesConnectionUseCase,
      this._connectionInvitation,
      this._checkConnectionInvitationAccepted)
      : super(const ConnectionPageState.initial());

  late final RetrieveAriesConnectionDataUseCase _connectionDataUseCase;
  late final InviteeAcceptConnectionInvitationUseCase
      _createAriesConnectionUseCase;
  late final InviterCreateConnectionInvitationUseCase _connectionInvitation;
  late final InviterCheckConnectionInvitationAcceptedUseCase
      _checkConnectionInvitationAccepted;

  void getConnectionsData() {
    try {
      _connectionDataUseCase
          .getConnectionsData()
          .then((value) => emit(ConnectionPageState.getConnectionsData(
              connections: value.map((e) => e.name).toList())))
          .catchError(
              (e) => emit(ConnectionPageState.error(message: e.toString())));
    } catch (e) {
      emit(ConnectionPageState.error(message: e.toString()));
    }
  }

  void inviteeAcceptConnectionInvitation({required String connectionUrl}) {
    try {
      _createAriesConnectionUseCase
          .createConnection(connectionUrl: connectionUrl)
          .then((value) => emit(
              ConnectionPageState.acceptedConnectionInvitation(
                  connectionName: value.name)))
          .catchError(
              (e) => emit(ConnectionPageState.error(message: e.toString())));
    } catch (e) {
      emit(ConnectionPageState.error(message: e.toString()));
    }
  }

  void inviterCreateConnectionInvitation() {
    try {
      _connectionInvitation
          .createInvite()
          .then((value) => emit(
              ConnectionPageState.inviterCreatedConnectionInvitation(
                  invitation: value.inviteUrl!,
                  connectionHandle: value.connectionHandle!)))
          .catchError(
              (e) => emit(ConnectionPageState.error(message: e.toString())));
    } catch (e) {
      emit(ConnectionPageState.error(message: e.toString()));
    }
  }

  void inviterCheckInvitationAccepted(
      {String connectionHandle = "", bool isToDeleteHandle = false}) {
    try {
      String handle = state.maybeMap(
          inviterCreatedConnectionInvitation: (v) => v.connectionHandle,
          inviterCreatedConnection: (v) => v.connectionHandle,
          inviterCheckedInvitation: (v) => v.connectionHandle,
          orElse: () => connectionHandle);

      _checkConnectionInvitationAccepted
          .isInvitationAccepted(
              connectionHandle: handle, isToDeleteHandle: isToDeleteHandle)
          .then((value) {
        if (value.pairwiseDid?.isNotEmpty == true) {
          emit(ConnectionPageState.inviterCreatedConnection(
              connectionName: value.name, connectionHandle: handle));
        } else {
          emit(ConnectionPageState.inviterCheckedInvitation(
              connectionHandle: handle));
        }
      }).catchError((e) {
        emit(ConnectionPageState.error(message: e.toString()));
      });
    } catch (e) {
      emit(ConnectionPageState.error(message: e.toString()));
    }
  }
}
