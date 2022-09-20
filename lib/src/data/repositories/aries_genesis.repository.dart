import 'package:flutter_vcx_demo/src/data/datasources/aries_genesis.datasource.dart';

abstract class IAriesGenesisRepository {
  Future<String> getGenesisFilePath();

  Future<bool> deleteGenesisFile();
}

class AriesGenesisRepository implements IAriesGenesisRepository {
  late final IAriesGenesisDatasource _ariesGenesisDatasource;

  AriesGenesisRepository({ariesGenesisDatasource})
      : _ariesGenesisDatasource =
            ariesGenesisDatasource ?? AriesGenesisDatasource();

  @override
  Future<bool> deleteGenesisFile() {
    return _ariesGenesisDatasource.deleteGenesisFile();
  }

  @override
  Future<String> getGenesisFilePath() {
    return _ariesGenesisDatasource.getGenesisFilePath();
  }
}
