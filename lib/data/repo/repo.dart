import 'package:get_it/get_it.dart';
import 'package:wts_bloc/data/repo/arrest/arrest_repo.dart';
import 'package:wts_bloc/data/repo/arrest/arrest_repo_impl.dart';
import 'package:wts_bloc/data/repo/collaborative/collaborative_repo.dart';
import 'package:wts_bloc/data/repo/collaborative/collaborative_repo_impl.dart';
import 'package:wts_bloc/data/repo/master_data/master_data_repo.dart';
import 'package:wts_bloc/data/repo/master_data/master_data_repo_impl.dart';
import 'package:wts_bloc/data/repo/news/news_repo.dart';
import 'package:wts_bloc/data/repo/news/news_repo_impl.dart';
import 'package:wts_bloc/data/repo/profile/profile_repo.dart';
import 'package:wts_bloc/data/repo/profile/profile_repo_impl.dart';

import 'dashboard/dashboard_repo.dart';
import 'dashboard/dashboard_repo_impl.dart';
import 'establish/establish_repo.dart';
import 'establish/establish_repo_impl.dart';
import 'home/product/product_repo.dart';
import 'home/product/product_repo_impl.dart';
import 'login/login_repo.dart';
import 'login/login_repo_impl.dart';

final getIt = GetIt.instance;

void initRepo() {
  getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl());
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl());
  getIt.registerLazySingleton<DashboardRepo>(() => DashboardRepoImpl());
  getIt.registerLazySingleton<EstablishRepo>(() => EstablishRepoImpl());
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());
  getIt.registerLazySingleton<ArrestRepo>(() => ArrestRepoImpl());
  getIt.registerLazySingleton<CollaborativeRepo>(() => CollaborativeRepoImpl());
  getIt.registerLazySingleton<MasterDataRepo>(() => MasterDataRepoImpl());
  getIt.registerLazySingleton<NewsRepo>(() => NewsRepoImpl());
}

ProductRepo get productRepo => getIt.get<ProductRepo>();
LoginRepo get loginRepo => getIt.get<LoginRepo>();
DashboardRepo get dashboardRepo => getIt.get<DashboardRepo>();
EstablishRepo get establishRepo => getIt.get<EstablishRepo>();
ProfileRepo get profileRepo => getIt.get<ProfileRepo>();
ArrestRepo get arrestRepo => getIt.get<ArrestRepo>();
CollaborativeRepo get collaborativeRepo => getIt.get<CollaborativeRepo>();
MasterDataRepo get masterDataRepo => getIt.get<MasterDataRepo>();
NewsRepo get newsRepo => getIt.get<NewsRepo>();
