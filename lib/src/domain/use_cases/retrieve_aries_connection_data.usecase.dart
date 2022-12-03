import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';

import '../../data/repositories/aries_connection.repository.dart';

class RetrieveAriesConnectionDataUseCase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

  RetrieveAriesConnectionDataUseCase({ariesConnectionRepository})
      : _ariesConnectionRepository =
      ariesConnectionRepository ?? AriesConnectionRepository();

  Future<List<ConnectionData>> getConnectionsData() {
    return _ariesConnectionRepository.getConnectionsData();
  }
}