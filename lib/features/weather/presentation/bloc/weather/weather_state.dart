part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  final Location location;
  const WeatherLoaded({required this.weather, required this.location})
      : super();
}

class WeatherError extends WeatherState {
  final String message;
  const WeatherError({required this.message}) : super();
}
