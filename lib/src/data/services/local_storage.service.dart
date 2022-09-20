import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

abstract class ILocalStorage<T> {
  late String dataRef;

  Future<void> save(T data);

  Future<T?> get();

  Future<bool> delete();

  String toJsonString(T data);

  T toData(String data);
}

abstract class EncryptedLocalStorage<T> implements ILocalStorage<T> {
  final EncryptedSharedPreferences _encryptedSharedPreferences =
      EncryptedSharedPreferences();

  @override
  Future<bool> delete() {
    return _encryptedSharedPreferences.remove(dataRef);
  }

  @override
  Future<T?> get() {
    return _encryptedSharedPreferences
        .getString(dataRef)
        .then((value) {
     return value.isEmpty ? null : toData(value);
    });
  }

  @override
  Future<void> save(T data) {
    return _encryptedSharedPreferences.setString(dataRef, toJsonString(data));
  }
}
