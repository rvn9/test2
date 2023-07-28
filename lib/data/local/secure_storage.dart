import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorge {
  final secureStorage = const FlutterSecureStorage();

  SecureStorge();

  factory SecureStorge.create() => SecureStorge();

  Future<String?> getToken() async {
    final uid = await secureStorage.read(key: 'token');
    return uid;
  }

  Future<void> setToken(String token) async {
    await secureStorage.write(key: 'token', value: token);
  }

  Future<void> clearToken() async {
    await secureStorage.delete(key: 'token');
  }
}
