import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app/routes/routes_constant.dart';
import '../blocs/profile/profile_bloc.dart';
import '../local_storage.dart';
import '../main.dart';
import '../utils/constants/key_localstorage.dart';
import '../utils/constants/text_style.dart';
import 'arrest/arrest_list_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'history/history_screen.dart';
import 'information/information_screen.dart';
import 'weight_unit_screen/weight_unit_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  final int index_menu;
  const BottomNavigationBarScreen({super.key, required this.index_menu});

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final LocalStorage _storage = LocalStorage();

  static final List<Widget> _widgetOptions = [
    const WeightUnitScreen(),
    const InformationScreen(title: 'ข่าวสาร'),
    const DashboardScreen(),
    const HistoryScreen(title: 'ดูข้อมูลย้อนหลัง'),
    const ArrestListScreen(),
  ];

  late int _selectedIndex;
  String? _cachedAccessToken;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index_menu;
    _loadAccessToken();
  }

  Future<void> _loadAccessToken() async {
    _cachedAccessToken =
        await _storage.getValueString(KeyLocalStorage.accessToken);
  }

  Future<bool> _isLoggedIn() async {
    _cachedAccessToken ??=
        await _storage.getValueString(KeyLocalStorage.accessToken);
    return _cachedAccessToken != null && _cachedAccessToken!.isNotEmpty;
  }

  Future<void> _onItemTapped(int index) async {
    if (index == 4) {
      final isLoggedIn = await _isLoggedIn();
      if (!isLoggedIn) {
        if (mounted) {
          Navigator.pushNamed(context, RoutesName.loginScreen);
        }
        return;
      }
    }

    if (mounted) {
      context.read<ProfileBloc>().add(const GetProfileEvent());
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFD9D9D9),
            blurRadius: 5,
            offset: Offset(1, 0),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
        child: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: colorScheme.surface,
            useLegacyColorScheme: false,
            unselectedItemColor: colorScheme.onSurface,
            items: _buildNavigationItems(colorScheme),
            onTap: _onItemTapped,
            unselectedLabelStyle:
                AppTextStyle.label12normal(color: colorScheme.onSurface),
            selectedLabelStyle:
                AppTextStyle.label12normal(color: colorScheme.surface),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationItems(ColorScheme colorScheme) {
    return [
      _buildNavItem(
        index: 0,
        iconPath: 'assets/svg/entypo_traffic-cone.svg',
        label: 'จัดตั้งหน่วย',
        colorScheme: colorScheme,
      ),
      _buildNavItem(
        index: 1,
        iconPath: 'assets/svg/iconamoon_news-fill.svg',
        label: 'ข่าวสาร',
        colorScheme: colorScheme,
      ),
      _buildNavItem(
        index: 2,
        iconPath: 'assets/svg/mage_dashboard-fill.svg',
        label: 'แดชบอร์ด',
        colorScheme: colorScheme,
      ),
      _buildNavItem(
        index: 3,
        iconPath: 'assets/svg/mdi_graph-line.svg',
        label: 'ข้อมูลย้อนหลัง',
        colorScheme: colorScheme,
      ),
      BottomNavigationBarItem(
        icon: Container(
          width: 20.h,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Image.asset(
            'assets/images/handcuffs.png',
            color: _selectedIndex == 4
                ? colorScheme.surface
                : colorScheme.onSurface,
          ),
        ),
        label: 'การจับกุม',
      ),
    ];
  }

  BottomNavigationBarItem _buildNavItem({
    required int index,
    required String iconPath,
    required String label,
    required ColorScheme colorScheme,
  }) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(
            _selectedIndex == index
                ? colorScheme.surface
                : colorScheme.onSurface,
            BlendMode.srcIn,
          ),
          width: 20.h,
        ),
      ),
      label: label,
    );
  }
}
