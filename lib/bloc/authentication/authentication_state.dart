part of 'authentication_cubit.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = _AuthenticationStateInitial;
  const factory AuthenticationState.loading() = _AuthenticationStateLoading;
  const factory AuthenticationState.signIn() = _AuthenticationStateLogin;
  const factory AuthenticationState.signUp() = _AuthenticationStateSignUp;
  const factory AuthenticationState.signOut() = _AuthenticationStateLogout;
  const factory AuthenticationState.error(Exception errorObject) =
      _AuthenticationStatesError;
}
