import 'package:flutter_vcx_demo/src/data/datasources/aries_genesis.datasource.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesGenesisRepository {
  Future<String> getGenesisFilePath();

  Future<bool> deleteGenesisFile();
}

@LazySingleton(as: IAriesGenesisRepository)
class AriesGenesisRepository implements IAriesGenesisRepository {
  late final IAriesGenesisDatasource _ariesGenesisDatasource;

  AriesGenesisRepository(this._ariesGenesisDatasource);

  @override
  Future<bool> deleteGenesisFile() {
    return _ariesGenesisDatasource.deleteGenesisFile();
  }

  @override
  Future<String> getGenesisFilePath() {
    return _ariesGenesisDatasource.getGenesisFilePath();
  }
}
