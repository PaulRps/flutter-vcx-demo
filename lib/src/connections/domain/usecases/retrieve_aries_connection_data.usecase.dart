import 'package:flutter_vcx_demo/src/connections/domain/entities/connection_data.dart';
import 'package:injectable/injectable.dart';

import '../connection.repository.dart';

@Injectable()
class RetrieveAriesConnectionDataUseCase {
  late final IConnectionRepository _ariesConnectionRepository;

  RetrieveAriesConnectionDataUseCase(this._ariesConnectionRepository);

  Future<List<ConnectionData>> getConnectionsData() {
    return _ariesConnectionRepository.getConnectionsData();
  }
}
