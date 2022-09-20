import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';

import '../../data/repositories/aries_connection.repository.dart';

class RetrieveConnectionDataUsecase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

  RetrieveConnectionDataUsecase({ariesConnectionRepository})
      : _ariesConnectionRepository =
      ariesConnectionRepository ?? AriesConnectionRepository();

  Future<ConnectionData> getConnectionData() {
    return _ariesConnectionRepository.getConnectionData();
  }
}