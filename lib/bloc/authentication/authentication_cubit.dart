import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_app2/repositores/authentication_repostory.dart';

import '../../inejctor.dart';

part 'authentication_cubit.freezed.dart';
part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepository _authenticationRepository;

  AuthenticationCubit(this._authenticationRepository)
      : super(const AuthenticationState.initial());

  factory AuthenticationCubit.create() => AuthenticationCubit(getIt.get());

  void signIn({required String email, required String password}) async {
    emit(const AuthenticationState.loading());
    final result = await _authenticationRepository.signIn(
      email: email,
      password: password,
    );
    result.fold(
      (l) {
        emit(AuthenticationState.error(l));
      },
      (r) async {
        emit(const AuthenticationState.signIn());
      },
    );
  }

  void signUp({
    required String name,
    required String password,
    required String email,
  }) async {
    emit(const AuthenticationState.loading());
    final result = await _authenticationRepository.signUp(
      name: name,
      email: email,
      password: password,
    );
    result.fold(
      (l) {
        emit(AuthenticationState.error(l));
      },
      (r) async {
        emit(const AuthenticationState.signUp());
      },
    );
  }

  void signOut() async {
    emit(const AuthenticationState.loading());
    final result = await _authenticationRepository.signOut();
    result.fold(
      (l) {
        emit(AuthenticationState.error(l));
      },
      (r) async {
        emit(const AuthenticationState.signOut());
      },
    );
  }
}
