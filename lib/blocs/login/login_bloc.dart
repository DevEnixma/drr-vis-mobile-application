import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/login/login_req.dart';
import '../../data/models/login/login_res.dart';
import '../../data/repo/repo.dart';
import '../../local_storage.dart';
import '../../utils/constants/key_localstorage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LocalStorage _storage = LocalStorage();

  LoginBloc() : super(const LoginState()) {
    on<PostLoginEvent>(_onPostLogin);
    on<RefreshTokenEvent>(_onRefreshToken);
  }

  Future<void> _onPostLogin(
    PostLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    try {
      final result = await _performLogin(event.bodyReq);

      await _saveCredentials(
        accessToken: result.accessToken.toString(),
        refreshToken: result.refreshToken.toString(),
        username: event.bodyReq.username.toString(),
        password: event.bodyReq.password.toString(),
      );

      emit(state.copyWith(
        loginStatus: LoginStatus.success,
        login: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        loginError: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshToken(
    RefreshTokenEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));

    try {
      final username = await _storage.getValueString(KeyLocalStorage.username);
      final password = await _storage.getValueString(KeyLocalStorage.password);

      final payload = LoginModelReq(
        username: username,
        password: password,
      );

      final result = await _performLogin(payload);

      await _saveCredentials(
        accessToken: result.accessToken.toString(),
        refreshToken: result.refreshToken.toString(),
      );

      emit(state.copyWith(
        loginStatus: LoginStatus.success,
        login: result,
      ));
    } catch (e) {
      emit(state.copyWith(
        loginStatus: LoginStatus.error,
        loginError: e.toString(),
      ));
    }
  }

  Future<LoginModelRes> _performLogin(LoginModelReq credentials) async {
    final body = json.encode(credentials.toJson());
    final response = await loginRepo.postLogin(body);

    if (response.statusCode >= 200 && response.statusCode < 400) {
      return LoginModelRes.fromJson(response.data);
    }

    throw Exception(response.error ?? 'Login failed');
  }

  Future<void> _saveCredentials({
    required String accessToken,
    required String refreshToken,
    String? username,
    String? password,
  }) async {
    await _storage.setValueString(KeyLocalStorage.accessToken, accessToken);
    await _storage.setValueString(KeyLocalStorage.refreshToken, refreshToken);

    if (username != null) {
      await _storage.setValueString(KeyLocalStorage.username, username);
    }
    if (password != null) {
      await _storage.setValueString(KeyLocalStorage.password, password);
    }

    await _storage.setValueBool(KeyLocalStorage.isUser, true);
  }
}
