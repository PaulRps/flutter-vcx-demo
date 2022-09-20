import 'dart:io';

import 'package:flutter_vcx_demo/src/data/services/aries_genesis.service.dart';
import 'package:path_provider/path_provider.dart';

abstract class IAriesGenesisDatasource {
  Future<String> getGenesisFilePath();

  Future<bool> deleteGenesisFile();
}

class AriesGenesisDatasource implements IAriesGenesisDatasource {
  late final IAriesGenesisService _genesisService;

  AriesGenesisDatasource({genesisService})
      : _genesisService = genesisService ?? AriesGenesisService();

  @override
  Future<String> getGenesisFilePath() {
    return _genesisService
        .getGenesisData()
        .then((data) => _GenesisFile.getGenesisPath(data));
  }

  @override
  Future<bool> deleteGenesisFile() {
    return _GenesisFile.deleteGenesisFile();
  }
}

class _GenesisFile {
  static const String _GENESIS_FILE_NAME = "pool_config";
  static const String _GENESIS_FILE_EXTENSION = ".txn";

  static Future<String> getGenesisPath(String data) async {
    var genesisFile = await _FileUtil.findFileInTempDir(
        _GENESIS_FILE_NAME, _GENESIS_FILE_EXTENSION);

    if (genesisFile == null) {
      genesisFile = await _FileUtil.createAndWriteFileInTempDir(
          _GENESIS_FILE_NAME, _GENESIS_FILE_EXTENSION, data);
    }

    return genesisFile.path;
  }

  static Future<bool> deleteGenesisFile() async {
    return _FileUtil.deleteFileInTempDir(
        _GENESIS_FILE_NAME, _GENESIS_FILE_EXTENSION);
  }
}

class _FileUtil {
  static Future<String> getTemporaryDir() async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }

  static Future<File> createAndWriteFileInTempDir(
      String fileName, String fileExtension, String data) async {
    var tempDir = await getTemporaryDir();

    var randomString = DateTime.now().millisecondsSinceEpoch.toString();
    var file = File("$tempDir/${fileName}_$randomString$fileExtension");

    return file.writeAsString(data);
  }

  static Future<bool> deleteFileInTempDir(
      String fileName, String fileExtension) async {
    var file = await findFileInTempDir(fileName, fileExtension);

    if (file == null) return true;

    await file.delete();
    var wasDeleted = !(await file.exists());

    return wasDeleted;
  }

  static Future<File?> findFileInTempDir(
      String fileName, String fileExtension) async {
    var tempDir = await getTemporaryDir();
    var dir = Directory("$tempDir");

    var fileList = await dir.list().toList();

    var searchResult = fileList.where((file) =>
        file.path.endsWith(fileExtension) && file.path.contains(fileName));

    FileSystemEntity? foundFile =
        searchResult.isNotEmpty && searchResult.first is File
            ? searchResult.first
            : null;

    return foundFile?.path.isNotEmpty == true ? File(foundFile!.path) : null;
  }
}
