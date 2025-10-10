import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wts_bloc/app/routes/routes.dart';
import 'package:wts_bloc/blocs/arrest/arrest_bloc.dart';
import 'package:wts_bloc/blocs/collaborative/collaborative_bloc.dart';
import 'package:wts_bloc/blocs/news/news_bloc.dart';
import 'package:wts_bloc/blocs/profile/profile_bloc.dart';
import 'package:wts_bloc/blocs/province/province_bloc.dart';
import 'package:wts_bloc/blocs/vehicle_car/vehicle_car_bloc.dart';
import 'package:wts_bloc/blocs/weight_car/weight_car_bloc.dart';
import 'package:wts_bloc/utils/constants/theme_config.dart';

import '../blocs/dashboard/dashboard_bloc.dart';
import '../blocs/establish/establish_bloc.dart';
import '../blocs/home/product/product_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/master_data/province_master/province_master_bloc.dart';
import '../blocs/materials/materials_bloc.dart';
import '../blocs/ways/ways_bloc.dart';
import '../blocs/weight_unit/weight_unit_bloc.dart';
import 'routes/routes_constant.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final productBloc = BlocProvider(create: (context) => ProductBloc());
    final loginBloc = BlocProvider(create: (context) => LoginBloc());
    final dashboardBloc = BlocProvider(create: (context) => DashboardBloc());
    final establishBloc = BlocProvider(create: (context) => EstablishBloc());
    final profile = BlocProvider(create: (context) => ProfileBloc());
    final collaborative = BlocProvider(create: (context) => CollaborativeBloc());
    final waysBloc = BlocProvider(create: (context) => WaysBloc());
    final vehicleBloc = BlocProvider(create: (context) => VehicleCarBloc());
    final provinceBloc = BlocProvider(create: (context) => ProvinceBloc());
    final materialBloc = BlocProvider(create: (context) => MaterialsBloc());
    final weightCarBloc = BlocProvider(create: (context) => WeightCarBloc());
    final newsBloc = BlocProvider(create: (context) => NewsBloc());
    final arrestBloc = BlocProvider(create: (context) => ArrestBloc());
    final provinceMasterBloc = BlocProvider(create: (context) => ProvinceMasterBloc());
    final weightUnitBloc = BlocProvider(create: (context) => WeightUnitBloc());

    return MultiBlocProvider(
      providers: [
        productBloc,
        loginBloc,
        dashboardBloc,
        establishBloc,
        profile,
        collaborative,
        waysBloc,
        vehicleBloc,
        provinceBloc,
        materialBloc,
        weightCarBloc,
        newsBloc,
        arrestBloc,
        provinceMasterBloc,
        weightUnitBloc,
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: false,
          splitScreenMode: false,
          builder: (_, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeConfig.getThemeData(context),
              locale: const Locale('th', 'TH'),
              initialRoute: RoutesName.splashScreen,
              onGenerateRoute: Routes.generateRoute,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', 'US'),
                Locale('th', 'TH'),
              ],
              builder: (BuildContext context, Widget? child) {
                final MediaQueryData data = MediaQuery.of(context);
                return MediaQuery(
                  data: data.copyWith(
                    textScaler: const TextScaler.linear(1.05),
                  ),
                  child: child!,
                );
              },
            );
          }),
    );
  }
}
