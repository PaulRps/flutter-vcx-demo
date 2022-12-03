import 'dart:async';

import 'package:flutter_vcx_demo/src/data/datasources/aries_connection.datasource.dart';
import 'package:flutter_vcx_demo/src/data/datasources/connection_data_storage.datasource.dart';
import 'package:flutter_vcx_demo/src/data/dtos/aries_connection_invitation_response.dto.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';

import '../dtos/aries_create_connection_response.dto.dart';
import '../dtos/connection_data.dto.dart';

abstract class IAriesConnectionRepository {
  Future<ConnectionData> createConnection(
      String connectionUrl, String sourceId);

  Future<AriesConnectionInvitationResponseDto> createConnectionInvitation();

  Future<AriesCreateConnectionResponseDto> checkConnectionInvitation(
      String connectionHandle, bool isToDeleteHandle);

  Future<void> saveConnectionData(ConnectionData data);

  Future<List<ConnectionData>> getConnectionsData();

  Future<bool> deleteConnectionData();
}

class AriesConnectionRepository implements IAriesConnectionRepository {
  late final IAriesConnectionDatasource _ariesConnectionDatasource;
  late final IConnectionDataStorageDatasource _connectionDataStorageDatasource;

  AriesConnectionRepository(
      {ariesConnectionDatasource, connectionDataStorageDatasource})
      : _ariesConnectionDatasource =
            ariesConnectionDatasource ?? AriesConnectionDatasource(),
        _connectionDataStorageDatasource = connectionDataStorageDatasource ??
            ConnectionDataStorageDatasource();

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
            pairwiseDid: e.pairwiseDto, connectionName: e.connectionName))
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
  Future<AriesCreateConnectionResponseDto> checkConnectionInvitation(
      String connectionHandle, bool isToDeleteHandle) {
    return _ariesConnectionDatasource.checkConnectionInvitation(
        connectionHandle, isToDeleteHandle);
  }

  @override
  Future<AriesConnectionInvitationResponseDto> createConnectionInvitation() {
    return _ariesConnectionDatasource.createConnectionInvitation();
  }
}
