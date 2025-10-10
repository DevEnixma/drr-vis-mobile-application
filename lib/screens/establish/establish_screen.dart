import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../app/routes/routes.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../local_storage.dart';
import '../../service/token_refresh.service.dart';
import '../../utils/constants/key_localstorage.dart';
import '../../utils/constants/text_style.dart';

class EstablishScreen extends StatefulWidget {
  const EstablishScreen({super.key});

  @override
  State<EstablishScreen> createState() => _EstablishScreenState();
}

class _EstablishScreenState extends State<EstablishScreen> {
  final LocalStorage storage = LocalStorage();

  String? accessToken;

  @override
  void initState() {
    super.initState();

    initData();
  }

  void initData() async {
    String? token = await storage.getValueString(KeyLocalStorage.accessToken);
    if (context.read<ProfileBloc>().state.profile != null && token != null) {
      setState(() {
        accessToken = token;
      });
    } else {
      setState(() {
        accessToken = null;
      });
      // Navigator.pushNamed(context, RoutesName.splashScreen);
    }
  }

  void getProfile() async {
    context.read<ProfileBloc>().add(const GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TokenRefreshService>(context, listen: false).startTokenRefreshTimer();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // constraints.maxWidth > 400 && constraints.maxWidth < 600  ? 140.h : 120.h;
          return Stack(
            children: [
              SizedBox(
                height: 140.h,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/bg_top.png',
                  fit: BoxFit.fill,
                ),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    constraints.maxWidth > 400 && constraints.maxWidth < 600 ? SizedBox.shrink() : SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 15.h),
                            SizedBox(
                              height: 45.h,
                              child: Image.asset('assets/images/logo.png'),
                            ),
                            SizedBox(width: 10.h),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('ระบบหน่วยชั่งน้ำหนักเคลื่อนที่', style: AppTextStyle.title18bold(color: Theme.of(context).colorScheme.surface)),
                                Text(
                                  'เริ่มปฏิบัติงานตามขั้นตอน',
                                  style: AppTextStyle.title14normal(
                                    color: const Color(0xFF56E4EE),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Routes.gotoProfile(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svg/iconamoon_profile-fill.svg',
                                color: Theme.of(context).colorScheme.surface,
                                width: 22.h,
                              ),
                              SizedBox(width: 15.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // EstablishListItem(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
