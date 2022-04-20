import 'package:dartz/dartz.dart';
import 'package:flutter_weather/features/weather/domain/entities/location.dart';

import '../../../../core/error/failure.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, Weather>> getWeatherData(int woeid);
  Future<Either<Failure, Location>> getLocationInformation(String location);
}
