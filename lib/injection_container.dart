import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_weather/core/platform/network_info.dart';
import 'package:flutter_weather/features/weather/data/datasources/weather_local_data_sources.dart';
import 'package:flutter_weather/features/weather/data/datasources/weather_remote_data_sources.dart';
import 'package:flutter_weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location_weather.dart';
import 'package:flutter_weather/features/weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! features
  sl.registerFactory(() => WeatherBloc(
        location: sl(),
        weather: sl(),
      ));

  // use cases
  sl.registerLazySingleton(() => GetLocationWeather(repository: sl()));
  sl.registerLazySingleton(() => GetLocation(repository: sl()));

  // repository
  sl.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(
      remoteDataSources: sl(), localDataSource: sl(), networkInfo: sl()));

  // data sources
  sl.registerLazySingleton<WeatherRemoteDataSources>(
      () => WeatherRemoteDateSourcesImpl(sl()));
  sl.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourcesImpl(sharedPreferences: sl()));

  //! core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => Client());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => sharedPreferences);
}
