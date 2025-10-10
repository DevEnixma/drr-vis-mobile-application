import 'package:flutter/material.dart';

import '../../app/routes/routes_constant.dart';
import 'splash_screen.dart';

class AfterSplashScreen extends StatefulWidget {
  const AfterSplashScreen({super.key});

  @override
  State<AfterSplashScreen> createState() => _AfterSplashScreenState();
}

class _AfterSplashScreenState extends State<AfterSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }

  @override
  void initState() {
    _navigateToHome();
    super.initState();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacementNamed(context, RoutesName.dashboardScreen);
    }
  }
}
