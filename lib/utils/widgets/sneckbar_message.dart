import 'package:flutter/material.dart';
import 'package:wts_bloc/utils/constants/text_style.dart';

import '../../local_storage.dart';
import '../../main.dart';
import '../../screens/splash/splash_screen.dart';
import '../libs/string_helper.dart';

Future<void> showSnackbarBottom(BuildContext context, String message, {Color? backgroundColor, Color? color}) async {
  logger.e('==[showSnackbarBottom]==> $message');

  final LocalStorage storage = LocalStorage();

  final errorCodes = StringHleper.findErrorCodes(message);
  logger.e('===showErrorSnackbar==2=$errorCodes');

  if (errorCodes.isNotEmpty) {
    logger.e('===showErrorSnackbar==3=$errorCodes');

    await storage.removeStorageLogout();

    if (context.mounted) {
      MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.error, // default color if null
      content: Text(
        message,
        style: AppTextStyle.title14bold(color: color ?? Theme.of(context).colorScheme.surface), // default text color if null
      ),
    ),
  );
}
