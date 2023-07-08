import 'entities/entities.dart';

abstract class IWalletRepository {
  Future<void> save(WalletData data);

  Future<WalletData> get();

  Future<bool> delete();
}
