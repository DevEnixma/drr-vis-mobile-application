import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../app/routes/routes.dart';
import '../../../app/routes/routes_constant.dart';
import '../../../local_storage.dart';
import '../../../utils/constants/key_localstorage.dart';
import '../../../utils/constants/text_style.dart';

class TitleDashboardWidget extends StatefulWidget {
  const TitleDashboardWidget({super.key});

  @override
  State<TitleDashboardWidget> createState() => _TitleDashboardWidgetState();
}

class _TitleDashboardWidgetState extends State<TitleDashboardWidget> {
  final LocalStorage _storage = LocalStorage();
  String? _accessToken;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      final token = await _storage.getValueString(KeyLocalStorage.accessToken);
      if (mounted) {
        setState(() {
          _accessToken = token;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _accessToken = null;
          _isLoading = false;
        });
      }
    }
  }

  bool get _isLoggedIn => _accessToken?.isNotEmpty == true;

  void _handleProfileTap() {
    if (_isLoggedIn) {
      Routes.gotoProfile(context);
    } else {
      Navigator.pushNamed(context, RoutesName.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLeftSection(colorScheme),
        _buildRightSection(colorScheme),
      ],
    );
  }

  Widget _buildLeftSection(ColorScheme colorScheme) {
    return Row(
      children: [
        SizedBox(width: 15.w),
        SizedBox(
          height: 45.h,
          child: Image.asset('assets/images/logo.png'),
        ),
        SizedBox(width: 10.w),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ระบบหน่วยชั่งน้ำหนักเคลื่อนที่',
              style: AppTextStyle.title18bold(color: colorScheme.surface),
            ),
            Text(
              'เริ่มปฏิบัติงานตามขั้นตอน',
              style: AppTextStyle.title14normal(
                color: const Color(0xFF56E4EE),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRightSection(ColorScheme colorScheme) {
    if (_isLoading) {
      return Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: SizedBox(
          width: 22.h,
          height: 22.h,
          child: const CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return GestureDetector(
      onTap: _handleProfileTap,
      child: Padding(
        padding: EdgeInsets.only(right: 15.w),
        child: SvgPicture.asset(
          _isLoggedIn ? 'assets/svg/ph_sign-out-bold.svg' : 'assets/svg/iconamoon_profile-fill.svg',
          color: colorScheme.surface,
          width: 22.h,
          height: 22.h,
        ),
      ),
    );
  }
}
