import 'package:flutter_vcx_demo/src/domain/entities/connection_data.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/aries_connection.repository.dart';

@Injectable()
class RetrieveAriesConnectionDataUseCase {
  late final IAriesConnectionRepository _ariesConnectionRepository;

  RetrieveAriesConnectionDataUseCase(this._ariesConnectionRepository);

  Future<List<ConnectionData>> getConnectionsData() {
    return _ariesConnectionRepository.getConnectionsData();
  }
}
