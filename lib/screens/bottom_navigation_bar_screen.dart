import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wts_bloc/main.dart';

import '../app/routes/routes_constant.dart';
import '../blocs/profile/profile_bloc.dart';
import '../local_storage.dart';
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
  final LocalStorage storage = LocalStorage();
  static List<Widget> _widgetOptions = <Widget>[
    const WeightUnitScreen(),
    // const EstablishScreen(),
    const InformationScreen(title: 'ข่าวสาร'),
    const DashboardScreen(),
    const HistoryScreen(title: 'ดูข้อมูลย้อนหลัง'),
    const ArrestListScreen(),
  ];

  int _selectedIndex = 2;
  bool isLogged = false;

  @override
  void initState() {
    _selectedIndex = widget.index_menu;
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    String? accessToken =
        await storage.getValueString(KeyLocalStorage.accessToken);
    print('accessToken $accessToken');
    print('isLogged checkLogin $isLogged');

    if (accessToken == null || accessToken.isEmpty) {
      setState(() {
        isLogged = true;
      });
    } else {
      setState(() {
        isLogged = false;
        _selectedIndex = 2;
      });
    }
  }

  void _onItemTapped(int index) async {
    // String? accessToken = await storage.getValueString(KeyLocalStorage.accessToken);
    // logger.i('=======[accessToken]==1======> $accessToken');

    // if (accessToken == null || accessToken.isEmpty) {
    //   logger.i('=======[accessToken]==2======> $accessToken');

    //   Navigator.pushNamed(context, RoutesName.loginScreen);
    // } else {
    //   logger.i('=======[accessToken]==3======> $accessToken');
    //   await getProfile();
    //   setState(() {
    //     _selectedIndex = index;
    //   });
    // }

    String? accessToken =
        await storage.getValueString(KeyLocalStorage.accessToken);

    if (index == 4) {
      if (accessToken == null || accessToken.isEmpty) {
        Navigator.pushNamed(context, RoutesName.loginScreen);
        return;
      }
    }

    await getProfile();
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> getProfile() async {
    logger.i('=======[accessToken]==4======>');

    context.read<ProfileBloc>().add(const GetProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0xffD9D9D9),
              blurRadius: 5,
              offset: Offset(1, 0),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32.r),
            topRight: Radius.circular(32.r),
          ),
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
              selectedItemColor: Theme.of(context).colorScheme.surface,
              useLegacyColorScheme: false,
              unselectedItemColor: Theme.of(context).colorScheme.onSurface,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/entypo_traffic-cone.svg',
                      // ignore: deprecated_member_use
                      color: _selectedIndex == 0
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,

                      width: 20.h,
                    ),
                  ),
                  label: 'จัดตั้งหน่วย',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/iconamoon_news-fill.svg',
                      // ignore: deprecated_member_use
                      color: _selectedIndex == 1
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                      width: 20.h,
                    ),
                  ),
                  label: 'ข่าวสาร',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/mage_dashboard-fill.svg',
                      // ignore: deprecated_member_use
                      color: _selectedIndex == 2
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                      width: 20.h,
                    ),
                  ),
                  label: 'แดชบอร์ด',
                ),
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/mdi_graph-line.svg',
                      // ignore: deprecated_member_use
                      color: _selectedIndex == 3
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                      width: 20.h,
                    ),
                  ),
                  label: 'ข้อมูลย้อนหลัง',
                ),
                BottomNavigationBarItem(
                  icon: Container(
                    width: 20.h,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Image.asset(
                      'assets/images/handcuffs.png',
                      color: _selectedIndex == 4
                          ? Theme.of(context).colorScheme.surface
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  label: 'การจับกุม',
                ),
              ],
              onTap: _onItemTapped,
              unselectedLabelStyle: AppTextStyle.label12normal(
                  color: Theme.of(context).colorScheme.onSurface),
              selectedLabelStyle: AppTextStyle.label12normal(
                  color: Theme.of(context).colorScheme.surface),
            ),
          ),
        ),
      ),
    );
  }
}
