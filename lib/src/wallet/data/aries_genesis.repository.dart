import 'package:flutter_vcx_demo/src/wallet/data/aries_genesis.datasource.dart';
import 'package:flutter_vcx_demo/src/wallet/domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IGenesisRepository)
class AriesGenesisRepository implements IGenesisRepository {
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
