
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:learnjava/data/repository/profile_repo.dart';
import 'package:learnjava/providers/auth_provider.dart';
import 'package:learnjava/providers/home_provider.dart';
import 'package:learnjava/providers/localization_provider.dart';
import 'package:learnjava/providers/profile_provider.dart';
import 'package:learnjava/providers/sound_provider.dart';
import 'package:learnjava/providers/splash_provider.dart';
import 'package:learnjava/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/datasource/remote/dio/logging_interceptor.dart';
import 'data/repository/auth_repo.dart';
import 'data/repository/home_repo.dart';
import 'data/repository/splash_repo.dart';
import 'helper/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
   sl.registerLazySingleton(() => NetworkInfo(sl()));
   sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl(), loggingInterceptor: sl(), sharedPreferences: sl()));
  //
  // // Repository
   sl.registerLazySingleton(() => AuthRepo(dioClient: sl(), sharedPreferences: sl()));
  // //sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
   sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), sharedPreferences: sl()));
  // sl.registerLazySingleton(() => OnBoardingRepo());
   sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl(), dioClient: sl()));
   sl.registerLazySingleton(() => HomeRepo());

  // Provider
  //
   sl.registerFactory(() => AuthProvider(authRepo: sl()));
  // //sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  // sl.registerFactory(() => OnBoardingProvider(onboardingRepo: sl()));
   sl.registerFactory(() => SplashProvider(splashRepo: sl()));
   sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl(), dioClient: sl()));
  // sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));

   sl.registerFactory(() => HomeProvider(homeRepo: sl()));
   sl.registerFactory(() => SoundProvider(sharedPreferences: sl()));
   sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  //
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

}
