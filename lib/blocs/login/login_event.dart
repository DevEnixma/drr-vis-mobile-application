part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class PostLoginEvent extends LoginEvent {
  final LoginModelReq bodyReq;

  const PostLoginEvent(this.bodyReq);

  @override
  List<Object> get props => [bodyReq];
}

final class RefreshTokenEvent extends LoginEvent {
  const RefreshTokenEvent();
}
