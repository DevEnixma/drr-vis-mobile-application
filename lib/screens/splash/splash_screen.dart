import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/routes/routes_constant.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../local_storage.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final LocalStorage storage = LocalStorage();

  bool isLogged = false;

  @override
  void initState() {
    super.initState();

    initScreen();
  }

  void initScreen() async {
    String? accessToken = await storage.getValueString(KeyLocalStorage.accessToken);

    if (accessToken != null) {
      setState(() {
        isLogged = true;
      });
    } else {
      setState(() {
        isLogged = false;
      });
      Navigator.pushNamed(context, RoutesName.dashboardScreen);
    }

    if (isLogged) {
      getProfile();
    }
  }

  void getProfile() async {
    context.read<ProfileBloc>().add(const GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: Duration(milliseconds: 1000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100.h,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          FadeInDown(duration: Duration(milliseconds: 700), child: Text('กรมทางหลวงชนบท', style: AppTextStyle.header32bold(color: Theme.of(context).colorScheme.surface))),
          FadeInDown(
            duration: Duration(milliseconds: 700),
            child: Text(
              'Vehicle Inspection System',
              style: AppTextStyle.header22bold(
                color: Color(0xFF56E4EE),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
