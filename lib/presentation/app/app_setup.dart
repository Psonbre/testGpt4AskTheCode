// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';
import 'package:revolvair/data/api_ranges_service_impl.dart';
import 'package:revolvair/data/api_station_service_impl.dart';
import 'package:revolvair/data/auth/auth_service_impl.dart';
import 'package:revolvair/data/location_service_impl.dart';
import 'package:revolvair/domain/services/auth/auth_service.dart';
import 'package:revolvair/domain/services/location_service.dart';
import 'package:revolvair/domain/services/ranges_service.dart';
import 'package:revolvair/domain/services/station_service.dart';
import 'package:revolvair/domain/usecases/auth/post_login_usecase.dart';
import 'package:revolvair/domain/usecases/auth/post_register_usecase.dart';
import 'package:revolvair/domain/usecases/get_location_usecase.dart';
import 'package:revolvair/domain/usecases/get_revolvair_aqi_usecase.dart';
import 'package:revolvair/domain/usecases/get_station_usecase.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:http/http.dart' as http;

GetIt locator = GetIt.instance;

class AppSetup {
  static Future<void> setupLocator() async {
    _registerServices();
    _registerUseCases();
  }

  static void _registerServices() {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => DialogService());
    locator.registerLazySingleton(() => http.Client());
    locator.registerLazySingleton<RangesService>(
        () => RangesServiceImpl(httpClient: locator<http.Client>()));
    locator.registerLazySingleton<StationService>(
        () => StationServiceImpl(httpClient: locator<http.Client>()));
    locator.registerLazySingleton<LocationService>(() => LocationServiceImpl());
    locator.registerLazySingleton<AuthService>(
        () => AuthServiceImpl(httpClient: locator<http.Client>()));
  }

  static void _registerUseCases() {
    locator.registerLazySingleton(
        () => GetRangesUseCase(rangesService: locator<RangesService>()));
    locator.registerLazySingleton(
        () => GetStationUseCase(stationService: locator<StationService>()));
    locator.registerLazySingleton(
        () => GetLocationUseCase(locationService: locator<LocationService>()));
    locator.registerLazySingleton(
        () => PostLoginUsecase(authService: locator<AuthService>()));
    locator.registerLazySingleton(
        () => PostRegisterUsecase(authService: locator<AuthService>()));
  }
}
