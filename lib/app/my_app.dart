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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc(), lazy: true),
        BlocProvider(create: (_) => LoginBloc(), lazy: true),
        BlocProvider(create: (_) => DashboardBloc(), lazy: true),
        BlocProvider(create: (_) => EstablishBloc(), lazy: true),
        BlocProvider(create: (_) => ProfileBloc(), lazy: true),
        BlocProvider(create: (_) => CollaborativeBloc(), lazy: true),
        BlocProvider(create: (_) => WaysBloc(), lazy: true),
        BlocProvider(create: (_) => VehicleCarBloc(), lazy: true),
        BlocProvider(create: (_) => ProvinceBloc(), lazy: true),
        BlocProvider(create: (_) => MaterialsBloc(), lazy: true),
        BlocProvider(create: (_) => WeightCarBloc(), lazy: true),
        BlocProvider(create: (_) => NewsBloc(), lazy: true),
        BlocProvider(create: (_) => ArrestBloc(), lazy: true),
        BlocProvider(create: (_) => ProvinceMasterBloc(), lazy: true),
        BlocProvider(create: (_) => WeightUnitBloc(), lazy: true),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: false,
        splitScreenMode: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DRR VIS',
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
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.05),
              ),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}
