import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

//Singleton Pattern
class SecureStorageService {
  static final FlutterSecureStorage _secureStorage =
      FlutterSecureStorage(aOptions: _getAndroidOptions());

  static FlutterSecureStorage get secureStorage => _secureStorage;

  SecureStorageService._internal();

  static init() {}
}
