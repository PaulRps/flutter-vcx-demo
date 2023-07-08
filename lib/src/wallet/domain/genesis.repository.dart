abstract class IGenesisRepository {
  Future<String> getGenesisFilePath();

  Future<bool> deleteGenesisFile();
}