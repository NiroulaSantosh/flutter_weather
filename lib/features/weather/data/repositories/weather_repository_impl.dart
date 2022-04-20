import 'package:dartz/dartz.dart';
import 'package:flutter_weather/core/error/exception.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/platform/network_info.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_data_sources.dart';
import '../datasources/weather_remote_data_sources.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSources remoteDataSources;
  final WeatherLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherRepositoryImpl({
    required this.remoteDataSources,
    required this.localDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, Location>> getLocationInformation(
      String location) async {
    if (await networkInfo.isConnected) {
      final locationData =
          await remoteDataSources.getLocationInformation(location);
      return Right(locationData);
    } else {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherData(int woeid) async {
    try {
      if (await networkInfo.isConnected) {
        final weather = await remoteDataSources.getWeatherData(woeid);
        await localDataSource.cachedWeather(weather);
        return Right(weather);
      } else {
        try {
          return Right(await localDataSource.getLastWeather());
        } on CacheException catch (_) {
          return const Left(CacheFailure());
        }
      }
    } on ServerException catch (_) {
      return const Left(ServerFailure());
    }
  }
}
