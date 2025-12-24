import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';

import 'app/config/server_config.dart';
import 'app/my_app.dart';
import 'data/repo/repo.dart';
import 'data/service/service.dart';
import 'service/token_refresh.service.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

final loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      await _initializeApp();

      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => TokenRefreshService(),
              lazy: true,
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stack) {
      logger.e('Uncaught error', error: error, stackTrace: stack);
    },
  );
}

Future<void> _initializeApp() async {
  initService();
  initRepo();
  apiService.init(baseUrl: ServerConfig.baseUrl);

  Bloc.observer = TalkerBlocObserver();

  assert(() {
    Logger.level = Level.debug;
    return true;
  }());

  final deviceLocale = PlatformDispatcher.instance.locale;
  final localeString = deviceLocale.toString();

  debugPrint('Device Locale: $localeString');

  Intl.defaultLocale = localeString;

  await initializeDateFormatting(localeString);
}
