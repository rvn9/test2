import 'package:dartz/dartz.dart';
import 'package:test_app2/data/local/secure_storage.dart';

import '../data/remote/authentication_service.dart';
import '../inejctor.dart';

class AuthRepository {
  final AuthService _authService;
  final SecureStorge _secureStorge;

  AuthRepository(this._authService, this._secureStorge);

  factory AuthRepository.create() => AuthRepository(getIt.get(), getIt.get());

  Future<Either<Exception, bool>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authService.signIn(
        email,
        password,
      );
      final token = result['data']['Token'];
      if (token != null) {
        _secureStorge.setToken(token);
      }
      return const Right(true);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  Future<Either<Exception, bool>> signUp({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      final result = await _authService.signUp(
        name: name,
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(Exception(e));
    }
  }

  Future<Either<Exception, bool>> signOut() async {
    try {
      await _secureStorge.clearToken();
      return const Right(true);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
