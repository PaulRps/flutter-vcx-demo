import 'package:flutter_vcx_demo/src/connections/domain/entities/entities.dart';

abstract class IConnectionRepository {
  Future<ConnectionData> createConnection(
      String connectionUrl, String sourceId);

  Future<ConnectionInvitationData> createConnectionInvitation();

  Future<ConnectionData> checkConnectionInvitation(
      String connectionHandle, bool isToDeleteHandle);

  Future<void> saveConnectionData(ConnectionData data);

  Future<List<ConnectionData>> getConnectionsData();

  Future<bool> deleteConnectionData();
}
