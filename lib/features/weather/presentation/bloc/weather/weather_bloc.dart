// ignore_for_file: constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/core/error/failure.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location_weather.dart';

import '../../../domain/entities/location.dart';
import '../../../domain/entities/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHED_FAILURE_MESSAGE = 'Cached Failure';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetLocation location;
  final GetLocationWeather weather;

  WeatherBloc({
    required this.location,
    required this.weather,
  }) : super(WeatherInitial()) {
    on<GetWeatherForLocation>((event, emit) async {
      emit(WeatherLoading());

      try {
        final fialureOrLocation =
            await location(StringParam(location: event.location));

        if (fialureOrLocation is Failure) {
          debugPrint("Failue");
          fialureOrLocation.fold(
              (l) => emit(WeatherError(message: _mapErrorToMessgae(l))),
              (r) => throw UnimplementedError());
        } else {
          final location = fialureOrLocation.toOption().toNullable();

          final fialureOrWeather =
              await weather(IntegerParams(woeid: location!.woeid!));

          fialureOrWeather.fold(
              (failure) =>
                  emit(WeatherError(message: _mapErrorToMessgae(failure))),
              (weather) =>
                  emit(WeatherLoaded(weather: weather, location: location)));
        }
      } catch (e) {
        emit(WeatherError(message: '$e'));
      }
    });
  }

  String _mapErrorToMessgae(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
