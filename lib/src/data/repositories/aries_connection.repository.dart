import 'package:flutter_vcx_demo/src/data/datasources/aries_connection.datasource.dart';
import 'package:flutter_vcx_demo/src/data/datasources/connection_data_storage.datasource.dart';
import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';

import '../dtos/connection_data.dto.dart';

abstract class IAriesConnectionRepository {
  Future<ConnectionData> createConnection(
      String connectionUrl, String inviteId);

  Future<void> saveConnectionData(ConnectionData data);

  Future<ConnectionData> getConnectionData();

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
      String connectionUrl, String inviteId) {
    return _ariesConnectionDatasource
        .createConnection(connectionUrl, inviteId)
        .then(
            (value) => ConnectionData(value.pairwiseDid, value.connectionName));
  }

  @override
  Future<ConnectionData> getConnectionData() {
    return _connectionDataStorageDatasource.get().then(
        (value) => ConnectionData(value?.pairwiseDto, value?.connectionName));
  }

  @override
  Future<void> saveConnectionData(ConnectionData data) {
    return _connectionDataStorageDatasource
        .save(ConnectionDataDto(data.pairwiseDid, data.connectionName));
  }

  @override
  Future<bool> deleteConnectionData() {
    return _connectionDataStorageDatasource.delete();
  }
}
