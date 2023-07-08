class ConnectionData {
  String? pairwiseDid;
  String? connectionName;

  String get name => connectionName ?? "Invitee";

  ConnectionData({this.pairwiseDid, this.connectionName});
}
