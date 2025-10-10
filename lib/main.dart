import 'dart:async';

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

var logger = Logger(
  printer: PrettyPrinter(),
);
var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void main() {
  runZonedGuarded(() {
    initService();
    initRepo();
    apiService.init(baseUrl: ServerConfig.baseUrl);

    Bloc.observer = TalkerBlocObserver();

    Logger.level = Level.debug;

    WidgetsFlutterBinding.ensureInitialized();
    Locale deviceLocale = WidgetsBinding.instance.window.locale;
    print("Device Locale: ${deviceLocale.toString()}");
    Intl.defaultLocale = deviceLocale.toString(); //ตั้งภาษาแรกตามพื้นที่
    initializeDateFormatting(deviceLocale.toString()); //ตั้งปฏิทินแรกตามพื้นที่
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // Only portrait mode
    ]);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TokenRefreshService()),
        ],
        child: MyApp(),
      ),
    );
    // runApp(const MyApp());
  }, (error, stack) {
    debugPrint("Error: $error");
  });
}
