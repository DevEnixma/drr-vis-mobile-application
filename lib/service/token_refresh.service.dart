import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../data/models/login/login_req.dart';
import '../data/models/login/login_res.dart';
import '../data/repo/repo.dart';
import '../local_storage.dart';
import '../main.dart';
import '../utils/constants/key_localstorage.dart';

class TokenRefreshService with ChangeNotifier {
  Timer? _timer;

  void startTokenRefreshTimer() {
    // ตรวจสอบว่ามี Timer ทำงานอยู่หรือไม่ ถ้ามีให้ข้าม
    if (_timer != null && _timer!.isActive) {
      return;
    }

    // เริ่มต้น Timer
    // _timer = Timer.periodic(Duration(seconds: 10), (timer) {
    _timer = Timer.periodic(Duration(minutes: 20), (timer) {
      refreshToken();
    });
  }

  Future<void> refreshToken() async {
    try {
      final LocalStorage storage = LocalStorage();

      var payload = LoginModelReq(
        username: await storage.getValueString(KeyLocalStorage.username),
        password: await storage.getValueString(KeyLocalStorage.password),
      );
      var body = json.encode(payload);
      final response = await loginRepo.postLogin(body);
      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = LoginModelRes.fromJson(response.data);
        await storage.setValueString(KeyLocalStorage.accessToken, result.accessToken.toString());
        await storage.setValueString(KeyLocalStorage.refreshToken, result.refreshToken.toString());

        await storage.setValueBool(KeyLocalStorage.isUser, true);
      }
    } catch (e) {
      logger.e("==111=====Error refreshing token: ${e.toString()}");
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }
}
