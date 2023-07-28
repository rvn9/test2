import 'package:get_it/get_it.dart';
import 'package:test_app2/data/local/secure_storage.dart';
import 'package:test_app2/data/remote/authentication_service.dart';
import 'package:test_app2/data/remote/base_service.dart';
import 'package:test_app2/repositores/authentication_repostory.dart';

final getIt = GetIt.instance;

class Injector {
  const Injector();

  static Future<void> initialize() async {
    const injector = Injector();
    injector._initializeService();
    injector._initializeRepository();
  }

  void _initializeService() {
    getIt.registerLazySingleton<BaseService>(() => BaseService.create());
    getIt.registerLazySingleton<AuthService>(() => AuthService.create());
    getIt.registerLazySingleton<SecureStorge>(() => SecureStorge.create());
  }

  void _initializeRepository() {
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepository.create());
  }
}
