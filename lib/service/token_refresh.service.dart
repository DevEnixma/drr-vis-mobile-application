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
  bool _isRefreshing = false;
  final LocalStorage _storage = LocalStorage();

  static const Duration _refreshInterval = Duration(minutes: 20);

  void startTokenRefreshTimer() {
    if (_timer?.isActive ?? false) {
      logger.i('Token refresh timer already running');
      return;
    }

    logger.i('Starting token refresh timer (every $_refreshInterval)');
    _timer = Timer.periodic(_refreshInterval, (_) => refreshToken());
  }

  Future<void> refreshToken() async {
    if (_isRefreshing) {
      logger.w('Token refresh already in progress, skipping...');
      return;
    }

    _isRefreshing = true;

    try {
      final username = await _storage.getValueString(KeyLocalStorage.username);
      final password = await _storage.getValueString(KeyLocalStorage.password);

      if (username == null || password == null) {
        logger.e('Cannot refresh token: missing credentials');
        stopTimer();
        return;
      }

      logger.i('Refreshing token for user: $username');

      final payload = LoginModelReq(username: username, password: password);
      final body = json.encode(payload);

      final response = await loginRepo.postLogin(body);

      if (response.statusCode >= 200 && response.statusCode < 400) {
        final result = LoginModelRes.fromJson(response.data);

        await Future.wait([
          _storage.setValueString(
            KeyLocalStorage.accessToken,
            result.accessToken.toString(),
          ),
          _storage.setValueString(
            KeyLocalStorage.refreshToken,
            result.refreshToken.toString(),
          ),
          _storage.setValueBool(KeyLocalStorage.isUser, true),
        ]);

        logger.i('Token refreshed successfully');
        notifyListeners();
      } else {
        logger.e('Token refresh failed: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      logger.e('Error refreshing token', error: e, stackTrace: stackTrace);
    } finally {
      _isRefreshing = false;
    }
  }

  void stopTimer() {
    if (_timer != null) {
      logger.i('Stopping token refresh timer');
      _timer?.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}
