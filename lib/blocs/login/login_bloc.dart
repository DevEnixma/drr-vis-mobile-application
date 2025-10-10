import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/login/login_req.dart';
import '../../data/models/login/login_res.dart';
import '../../data/repo/repo.dart';
import '../../local_storage.dart';
import '../../utils/constants/key_localstorage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // LoginBloc() : super(LoginInitial());
  LoginBloc() : super(const LoginState()) {
    on<PostLoginEvent>((event, emit) async {
      emit(state.copyWith(loginStatus: LoginStatus.loading));

      try {
        var body = json.encode(event.bodyReq.toJson());
        final response = await loginRepo.postLogin(body);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final result = LoginModelRes.fromJson(response.data);
          final LocalStorage storage = LocalStorage();
          await storage.setValueString(KeyLocalStorage.accessToken, result.accessToken.toString());
          await storage.setValueString(KeyLocalStorage.refreshToken, result.refreshToken.toString());

          await storage.setValueString(KeyLocalStorage.username, event.bodyReq.username.toString());
          await storage.setValueString(KeyLocalStorage.password, event.bodyReq.password.toString());

          await storage.setValueBool(KeyLocalStorage.isUser, true);

          emit(state.copyWith(loginStatus: LoginStatus.success, login: result));

          return;
        }

        emit(state.copyWith(loginStatus: LoginStatus.error, loginError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(loginStatus: LoginStatus.error, loginError: e.toString()));
        return;
      }
    });

    on<RefreshTokenEvent>((event, emit) async {
      try {
        emit(state.copyWith(loginStatus: LoginStatus.loading));
        final LocalStorage storage = LocalStorage();
        var payload = LoginModelReq(
          username: await storage.getValueString(KeyLocalStorage.username),
          password: await storage.getValueString(KeyLocalStorage.password),
        );
        var body = json.encode(payload);
        final response = await loginRepo.postLogin(body);
        if (response.statusCode >= 200 && response.statusCode < 400) {
          final result = LoginModelRes.fromJson(response.data);
          final LocalStorage storage = LocalStorage();
          await storage.setValueString(KeyLocalStorage.accessToken, result.accessToken.toString());
          await storage.setValueString(KeyLocalStorage.refreshToken, result.refreshToken.toString());

          await storage.setValueBool(KeyLocalStorage.isUser, true);

          emit(state.copyWith(loginStatus: LoginStatus.success, login: result));

          return;
        }

        emit(state.copyWith(loginStatus: LoginStatus.error, loginError: response.error));
        return;
      } catch (e) {
        emit(state.copyWith(loginStatus: LoginStatus.error, loginError: e.toString()));
        return;
      }
    });
  }
}
