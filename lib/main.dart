import 'dart:async';
import 'dart:ui'; // ✅ Import สำหรับ PlatformDispatcher

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

/// ✅ Global loggers - lazy initialization
final logger = Logger(
  printer: PrettyPrinter(),
);

final loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

Future<void> main() async {
  runZonedGuarded(
    () async {
      // ✅ Initialize Flutter binding first
      WidgetsFlutterBinding.ensureInitialized();

      // ✅ Set preferred orientations
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);

      // ✅ Initialize app services and configurations
      await _initializeApp();

      // ✅ Run app with providers
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => TokenRefreshService(),
              lazy: true, // Create only when needed
            ),
          ],
          child: const MyApp(),
        ),
      );
    },
    (error, stack) {
      // ✅ Log uncaught errors properly
      logger.e('Uncaught error', error: error, stackTrace: stack);
    },
  );
}

/// Initialize all app services and configurations
Future<void> _initializeApp() async {
  // Initialize services
  initService();
  initRepo();
  apiService.init(baseUrl: ServerConfig.baseUrl);

  // Setup Bloc observer
  Bloc.observer = TalkerBlocObserver();

  // Set logger level (only in debug mode)
  assert(() {
    Logger.level = Level.debug;
    return true;
  }());

  // ✅ Initialize locale with PlatformDispatcher (modern approach)
  final deviceLocale = PlatformDispatcher.instance.locale;
  final localeString = deviceLocale.toString();

  debugPrint('Device Locale: $localeString');

  // Set default locale for intl package
  Intl.defaultLocale = localeString;

  // Initialize date formatting for device locale
  await initializeDateFormatting(localeString);
}
