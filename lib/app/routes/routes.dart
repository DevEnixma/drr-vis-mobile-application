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
import '../../screens/arrest/arrest_screen.dart';

class Routes {
  Routes._();

  // Generate route based on route settings
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return _buildRoute(const AfterSplashScreen());

      case RoutesName.loginScreen:
        return _buildRoute(const LoginScreen());

      case RoutesName.dashboardScreen:
        return _buildRoute(BottomNavigationBarScreen(index_menu: 2));

      default:
        return _buildRoute(const _NotFoundScreen());
    }
  }

  // Helper method with generic type
  static MaterialPageRoute<T> _buildRoute<T>(Widget screen) {
    return MaterialPageRoute<T>(builder: (_) => screen);
  }

  // Navigate to bottom navigation and remove all previous routes
  static Future<void> gotoBottomNavigation(
    BuildContext context,
    int indexMenu,
  ) async {
    await Navigator.pushAndRemoveUntil(
      context,
      _buildRoute(BottomNavigationBarScreen(index_menu: indexMenu)),
      (route) => false,
    );
  }

  // Navigate to bottom navigation and wait for result
  static Future<Map<String, dynamic>?> gotoBottomNavigationRe(
    BuildContext context,
    int indexMenu,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(
        BottomNavigationBarScreen(index_menu: indexMenu),
      ),
    );
  }

  // Navigate to map screen
  static Future<Map<String, dynamic>?> gotoOpenStreetMap(
    BuildContext context,
    String title,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(OpenStreetMapScreen(title: title)),
    );
  }

  // Navigate to create weight unit screen
  static Future<Map<String, dynamic>?> gotoCreateWeightUnit(
    BuildContext context,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(const CreateWeightUnitScreen()),
    );
  }

  // Navigate to error screen
  static Future<Map<String, dynamic>?> gotoErrorScreen(
    BuildContext context,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(ErrorScreen()),
    );
  }

  // Navigate to weight unit details screen
  static Future<Map<String, dynamic>?> gotoWeightUnitDetailsScreen(
    BuildContext context,
    String tid,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(WeightUnitDetailsScreen(tid: tid)),
    );
  }

  // Navigate to unit details weighing trucks screen
  static Future<Map<String, dynamic>?> gotoUnitDetailsWeighingTrucks(
    BuildContext context,
    String tid,
    String tdId,
    bool isEdit,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(
        UnitDetailsWeighingTrucksScreen(
          tid: tid,
          tdId: tdId,
          isEdit: isEdit,
        ),
      ),
    );
  }

  // Navigate to establish success screen
  static Future<Map<String, dynamic>?> gotoEstablishSuccess(
    BuildContext context,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(EstablishSuccessScreen()),
    );
  }

  // Navigate to arrest form screen
  // ใช้ named parameters เพื่อ backward compatibility
  static Future<Map<String, dynamic>?> gotoArrestFormScreen({
    required BuildContext context,
    required MobileCarModel item,
  }) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(ArrestFormScreen(item: item)),
    );
  }

  // Navigate to preview file screen
  // ใช้ named parameters เพื่อ backward compatibility
  static Future<Map<String, dynamic>?> gotoPreviewFile({
    required BuildContext context,
    required String url,
    required String fileName,
  }) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(
        CustomPreviewFile(url: url, fileName: fileName),
      ),
    );
  }

  // Navigate to profile screen
  static Future<Map<String, dynamic>?> gotoProfile(
    BuildContext context,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(ProfileScreen()),
    );
  }

  // Navigate to information details screen
  static Future<Map<String, dynamic>?> gotoInformationDetails(
    BuildContext context,
    NewsModelRes item,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(InformationDetailsScreen(item: item)),
    );
  }

  // Navigate to history details screen
  static Future<Map<String, dynamic>?> gotoHistoryDetails(
    BuildContext context,
    MobileMasterModel item,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(HistoryDetailsScreen(item: item)),
    );
  }

  // Navigate to history details view screen
  static Future<Map<String, dynamic>?> gotoHistoryDetailsView(
    BuildContext context,
    String tid,
    String tdId,
  ) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(
        HistoryDetailsViewScreen(
          tid: tid,
          tdId: tdId,
        ),
      ),
    );
  }

  // Navigate to arrest screen
  // ใช้ named parameters เพื่อ backward compatibility
  static Future<Map<String, dynamic>?> gotoArrestScreen({
    required BuildContext context,
  }) async {
    return await Navigator.push<Map<String, dynamic>>(
      context,
      _buildRoute<Map<String, dynamic>>(
        const ArrestScreen(title: 'การจับกุม'),
      ),
    );
  }
}

// 404 Not Found Screen
class _NotFoundScreen extends StatelessWidget {
  const _NotFoundScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: EmptyWidget(
          title: '404',
          label: 'No route generated',
        ),
      ),
    );
  }
}
