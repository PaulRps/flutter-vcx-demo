import 'entities/entities.dart';

abstract class ISdkRepository {
  Future<bool> startSdk(SdkSettings dto);

  Future<bool> shutdownSdk({required bool deleteWallet});
}
