import 'package:flutter_weather/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_weather/core/usecases/usecase.dart';
import 'package:flutter_weather/features/weather/domain/entities/location.dart';
import 'package:flutter_weather/features/weather/domain/repositories/weather_repository.dart';

class GetLocation extends Usecase<Location, StringParam> {
  final WeatherRepository repository;
  GetLocation({required this.repository});
  @override
  Future<Either<Failure, Location>> call(StringParam params) async {
    return await repository.getLocationInformation(params.location);
  }
}

class StringParam {
  final String location;
  StringParam({required this.location});
}
