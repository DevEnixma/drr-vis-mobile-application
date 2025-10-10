import 'package:flutter/material.dart';
import 'package:wts_bloc/data/models/news/news_model_res.dart';
import 'package:wts_bloc/screens/splash/after_splash_screen.dart';
import 'package:wts_bloc/screens/widgets/empty_widget.dart';

import '../../data/models/establish/mobile_car_model.dart';
import '../../data/models/establish/mobile_master_model.dart';
import '../../screens/arrest/arrest_form_screen.dart';
import '../../screens/bottom_navigation_bar_screen.dart';
import '../../screens/dashboard/map/open_street_map_screen.dart';
import '../../screens/establish/establish_success_screen.dart';
import '../../screens/history/history_details_screen/history_details_screen.dart';
import '../../screens/history/history_details_view_screen.dart';
import '../../screens/information/information_details_screen.dart';
import '../../screens/login/login_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/weight_unit_screen/create_weight_unit_screen/create_weight_unit_screen.dart';
import '../../screens/weight_unit_screen/weight_unit_detail_screen/weight_unit_details_screen.dart';
import '../../screens/weight_unit_screen/weight_unit_detail_screen/widgets/unit_details_weighing_trucks_screen.dart';
import '../../screens/widgets/error_screen.dart';
import '../../utils/widgets/custom_preview_file.dart';
import 'routes_constant.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(builder: (context) => const AfterSplashScreen());
      case RoutesName.loginScreen:
        return MaterialPageRoute(builder: (context) => const LoginScreen());
      case RoutesName.dashboardScreen:
        return MaterialPageRoute(builder: (context) => BottomNavigationBarScreen(index_menu: 2));
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                EmptyWidget(title: '404', label: 'No route generate'),
              ],
            ),
          );
        });
    }
  }

  // ไม่รีเทินค่า ลบหน้าออกหมด
  static void gotoBottomNavigation(context, int index_menu) async {
    print('Routes gotoBottomNavigation');
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationBarScreen(index_menu: index_menu)),
      (Route<dynamic> route) => false,
    );
  }

  static Future<dynamic> gotoBottomNavigationRe(context, int index_menu) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BottomNavigationBarScreen(index_menu: index_menu)),
    );
    return data;
  }

  static Future<dynamic> gotoOpenStreetMap(context, String title) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OpenStreetMapScreen(title: title)),
    );
    return data;
  }

  static Future<dynamic> gotoCreateWeightUnit(context) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateWeightUnitScreen()),
    );
    return data;
  }

  //   static Future<dynamic> gotoSuccessScreen(context) async {
  //   Map<String, dynamic>? data = await Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) =>  SuccessScreen()),
  //   );
  //   return data;
  // }

  static Future<dynamic> gotoErrorScreen(context) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ErrorScreen()),
    );
    return data;
  }

  static Future<dynamic> gotoWeightUnitDetailsScreen(context, String tid) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeightUnitDetailsScreen(tid: tid)),
    );
    return data;
  }

  static Future<dynamic> gotoUnitDetailsWeighingTrucks(context, String tid, String tdId, bool isEdit) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UnitDetailsWeighingTrucksScreen(
          tid: tid,
          tdId: tdId,
          isEdit: isEdit,
        ),
      ),
    );
    return data;
  }

  static Future<dynamic> gotoEstablishSuccess(context) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EstablishSuccessScreen()),
    );
    return data;
  }

  static Future<dynamic> gotoArrestFormScreen({context, required MobileCarModel item}) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ArrestFormScreen(item: item)),
    );
    return data;
  }

  static Future<dynamic> gotoPreviewFile({context, required String url, nameFile}) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomPreviewFile(url: url, nameFile: nameFile)),
    );
    return data;
  }

  static Future<dynamic> gotoProfile(context) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileScreen()),
    );
    return data;
  }

  static Future<dynamic> gotoInformationDetails(context, NewsModelRes item) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InformationDetailsScreen(item: item)),
    );
    return data;
  }

  static Future<dynamic> gotoHistoryDetails(context, MobileMasterModel tid) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HistoryDetailsScreen(item: tid)),
    );
    return data;
  }

  static Future<dynamic> gotoHistoryDetailsView(context, String tid, String tdId) async {
    Map<String, dynamic>? data = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryDetailsViewScreen(
          tid: tid,
          tdId: tdId,
        ),
      ),
    );
    return data;
  }
}
