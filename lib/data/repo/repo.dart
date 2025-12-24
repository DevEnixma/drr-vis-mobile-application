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
  if (!getIt.isRegistered<ProductRepo>()) {
    getIt.registerLazySingleton<ProductRepo>(() => ProductRepoImpl());
  }
  if (!getIt.isRegistered<LoginRepo>()) {
    getIt.registerLazySingleton<LoginRepo>(() => LoginRepoImpl());
  }
  if (!getIt.isRegistered<DashboardRepo>()) {
    getIt.registerLazySingleton<DashboardRepo>(() => DashboardRepoImpl());
  }
  if (!getIt.isRegistered<EstablishRepo>()) {
    getIt.registerLazySingleton<EstablishRepo>(() => EstablishRepoImpl());
  }
  if (!getIt.isRegistered<ProfileRepo>()) {
    getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl());
  }
  if (!getIt.isRegistered<ArrestRepo>()) {
    getIt.registerLazySingleton<ArrestRepo>(() => ArrestRepoImpl());
  }
  if (!getIt.isRegistered<CollaborativeRepo>()) {
    getIt.registerLazySingleton<CollaborativeRepo>(
        () => CollaborativeRepoImpl());
  }
  if (!getIt.isRegistered<MasterDataRepo>()) {
    getIt.registerLazySingleton<MasterDataRepo>(() => MasterDataRepoImpl());
  }
  if (!getIt.isRegistered<NewsRepo>()) {
    getIt.registerLazySingleton<NewsRepo>(() => NewsRepoImpl());
  }
}

ProductRepo get productRepo => getIt<ProductRepo>();
LoginRepo get loginRepo => getIt<LoginRepo>();
DashboardRepo get dashboardRepo => getIt<DashboardRepo>();
EstablishRepo get establishRepo => getIt<EstablishRepo>();
ProfileRepo get profileRepo => getIt<ProfileRepo>();
ArrestRepo get arrestRepo => getIt<ArrestRepo>();
CollaborativeRepo get collaborativeRepo => getIt<CollaborativeRepo>();
MasterDataRepo get masterDataRepo => getIt<MasterDataRepo>();
NewsRepo get newsRepo => getIt<NewsRepo>();
