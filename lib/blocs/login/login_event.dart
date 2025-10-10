part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PostLoginEvent extends LoginEvent {
  final BuildContext context;
  final LoginModelReq bodyReq;

  const PostLoginEvent(this.bodyReq, this.context);
}

class RefreshTokenEvent extends LoginEvent {
  const RefreshTokenEvent();
}
