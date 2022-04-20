import 'package:equatable/equatable.dart';

enum WeatherState {
  snow,
  sleet,
  hall,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

enum WindDirectionCompass {
  north,
  northEast,
  east,
  southEast,
  south,
  southWest,
  west,
  northWest,
  unknown
}

class Weather extends Equatable {
  final double airPressure;
  final DateTime applicableDate;
  final DateTime created;
  final int humidity;
  final int id;
  final double maxTemp;
  final double minTemp;
  final int predictability;
  final double theTemp;
  final double visibility;
  final String weatherStateAbbr;
  final WeatherState weatherStateName;
  final double windDirection;
  final WindDirectionCompass windDirectionCompass;
  final double windSpeed;

  const Weather({
    required this.airPressure,
    required this.applicableDate,
    required this.created,
    required this.humidity,
    required this.id,
    required this.maxTemp,
    required this.minTemp,
    required this.predictability,
    required this.theTemp,
    required this.visibility,
    required this.weatherStateAbbr,
    required this.weatherStateName,
    required this.windDirection,
    required this.windDirectionCompass,
    required this.windSpeed,
  });

  @override
  List<Object?> get props => [
        airPressure,
        applicableDate,
        created,
        humidity,
        id,
        maxTemp,
        minTemp,
        predictability,
        theTemp,
        visibility,
        weatherStateAbbr,
        weatherStateName,
        windDirection,
        windDirectionCompass,
        windSpeed
      ];
}
