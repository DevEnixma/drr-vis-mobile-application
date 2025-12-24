import 'package:flutter/material.dart';
import 'package:wts_bloc/utils/constants/text_style.dart';

import '../../local_storage.dart';
import '../../main.dart';
import '../../screens/splash/splash_screen.dart';
import '../libs/string_helper.dart';

Future<void> showSnackbarBottom(
  BuildContext context,
  String message, {
  Color? backgroundColor,
  Color? color,
}) async {
  logger.e('==[showSnackbarBottom]==> $message');

  final LocalStorage storage = LocalStorage();
  final errorCodes = StringHleper.findErrorCodes(message);

  logger.e('===showErrorSnackbar==2=$errorCodes');

  if (errorCodes.isNotEmpty) {
    logger.e('===showErrorSnackbar==3=$errorCodes');

    await storage.removeStorageLogout();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
        (route) => false,
      );
    }

    return;
  }

  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.error,
        content: Text(
          message,
          style: AppTextStyle.title14bold(
            color: color ?? Theme.of(context).colorScheme.surface,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
