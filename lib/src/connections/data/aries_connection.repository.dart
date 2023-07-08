import 'dart:async';

import 'package:flutter_vcx_demo/src/connections/data/aries_connection.datasource.dart';
import 'package:flutter_vcx_demo/src/connections/data/connection_data_storage.datasource.dart';
import 'package:flutter_vcx_demo/src/connections/data/models/models.dart';
import 'package:flutter_vcx_demo/src/connections/domain/domain.dart';
import 'package:injectable/injectable.dart';

import 'connection.converter.dart';

@LazySingleton(as: IConnectionRepository)
class AriesConnectionRepository implements IConnectionRepository {
  late final IAriesConnectionDatasource _ariesConnectionDatasource;
  late final IConnectionDataStorageDatasource _connectionDataStorageDatasource;
  late final ConnectionConverter _converter;

  AriesConnectionRepository(this._ariesConnectionDatasource,
      this._connectionDataStorageDatasource, this._converter);

  @override
  Future<ConnectionData> createConnection(
      String connectionUrl, String sourceId) {
    return _ariesConnectionDatasource
        .createConnection(connectionUrl, sourceId)
        .then((value) => ConnectionData(
            pairwiseDid: value.pairwiseDid,
            connectionName: value.connectionName));
  }

  @override
  Future<List<ConnectionData>> getConnectionsData() {
    return _connectionDataStorageDatasource.get().then((value) => value
        .map((e) => ConnectionData(
            pairwiseDid: e.pairwiseDid, connectionName: e.connectionName))
        .toList());
  }

  @override
  Future<void> saveConnectionData(ConnectionData data) {
    return getConnectionsData().then((connections) {
      connections.add(data);
      var newConnections = connections
          .map((e) => ConnectionDataDto(e.pairwiseDid, e.connectionName))
          .toList();
      _connectionDataStorageDatasource.save(newConnections);
    });
  }

  @override
  Future<bool> deleteConnectionData() {
    return _connectionDataStorageDatasource.delete();
  }

  @override
  Future<ConnectionData> checkConnectionInvitation(
      String connectionHandle, bool isToDeleteHandle) {
    return _ariesConnectionDatasource
        .checkConnectionInvitation(connectionHandle, isToDeleteHandle)
        .then((value) => _converter.toConnectionData(value));
  }

  @override
  Future<ConnectionInvitationData> createConnectionInvitation() {
    return _ariesConnectionDatasource
        .createConnectionInvitation()
        .then((value) => _converter.toConnectionInvitationData(value));
  }
}
