import 'package:flutter/services.dart';

abstract class IAriesGenesisService {
  Future<String> getGenesisData();
}

class AriesGenesisService implements IAriesGenesisService {
  @override
  Future<String> getGenesisData() {
    return rootBundle.loadString('assets/aries/genesis.txt');
  }
}
