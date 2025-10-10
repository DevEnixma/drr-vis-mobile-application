part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final LoginStatus? loginStatus;
  final LoginModelRes? login;
  final String? loginError;

  const LoginState({
    this.loginStatus = LoginStatus.initial,
    this.login,
    this.loginError = '',
  });

  LoginState copyWith({
    LoginStatus? loginStatus,
    LoginModelRes? login,
    String? loginError,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      login: login ?? this.login,
      loginError: loginError ?? this.loginError,
    );
  }

  @override
  List<Object?> get props => [
        loginStatus,
        login,
        loginError,
      ];
}
