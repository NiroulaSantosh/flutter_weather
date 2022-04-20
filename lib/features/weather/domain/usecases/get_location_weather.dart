import 'package:equatable/equatable.dart';
import 'package:flutter_weather/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather/core/usecases/usecase.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';
import 'package:flutter_weather/features/weather/domain/repositories/weather_repository.dart';

class GetLocationWeather extends Usecase<Weather, IntegerParams> {
  final WeatherRepository repository;
  GetLocationWeather({required this.repository});

  @override
  Future<Either<Failure, Weather>> call(IntegerParams params) async {
    return await repository.getWeatherData(params.woeid);
  }
}

class IntegerParams extends Equatable {
  final int woeid;
  const IntegerParams({required this.woeid});

  @override
  List<Object?> get props => [woeid];
}
