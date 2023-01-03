import 'package:freezed_annotation/freezed_annotation.dart';

part 'connection_page.state.freezed.dart';

@freezed
abstract class ConnectionPageState with _$ConnectionPageState {
  const factory ConnectionPageState.initial() = ConnectionInitial;

  const factory ConnectionPageState.error({required String message}) =
      ConnectionError;

  const factory ConnectionPageState.acceptedConnectionInvitation(
      {required String connectionName}) = ConnectionAcceptedInvitation;

  const factory ConnectionPageState.inviterCreatedConnection(
      {@Default("Invitee") String connectionName, required String connectionHandle}) = ConnectionInviterCreated;

  const factory ConnectionPageState.inviterCheckedInvitation(
      {required String connectionHandle}) = ConnectionInviterCheckedInvitation;

  const factory ConnectionPageState.inviterCreatedConnectionInvitation(
      {required String invitation, required String connectionHandle}) = ConnectionInviterCreatedInvitation;

  const factory ConnectionPageState.getConnectionsData(
      {required List<String> connections}) = ConnectionsGetData;
}
