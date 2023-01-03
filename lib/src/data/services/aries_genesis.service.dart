import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

abstract class IAriesGenesisService {
  Future<String> getGenesisData();
}

@LazySingleton(as: IAriesGenesisService)
class AriesGenesisService implements IAriesGenesisService {
  @override
  Future<String> getGenesisData() {
    return rootBundle.loadString('assets/aries/genesis.txt');
  }
}
