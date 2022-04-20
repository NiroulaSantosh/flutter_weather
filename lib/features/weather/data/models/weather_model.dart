import 'package:flutter_weather/features/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel(
      {required double airPressure,
      required DateTime applicableDate,
      required DateTime created,
      required int humidity,
      required int id,
      required double maxTemp,
      required double minTemp,
      required int predictability,
      required double theTemp,
      required double visibility,
      required String weatherStateAbbr,
      required WeatherState weatherStateName,
      required double windDirection,
      required WindDirectionCompass windDirectionCompass,
      required double windSpeed})
      : super(
            airPressure: airPressure,
            applicableDate: applicableDate,
            created: created,
            humidity: humidity,
            id: id,
            maxTemp: maxTemp,
            minTemp: minTemp,
            predictability: predictability,
            theTemp: theTemp,
            visibility: visibility,
            weatherStateAbbr: weatherStateAbbr,
            weatherStateName: weatherStateName,
            windDirection: windDirection,
            windDirectionCompass: windDirectionCompass,
            windSpeed: windSpeed);

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        airPressure: json['air_pressure'],
        applicableDate: DateTime.parse(json['applicable_date']),
        created: DateTime.parse(json['created']),
        humidity: json['humidity'],
        id: json['id'],
        maxTemp: json['max_temp'],
        minTemp: json['min_temp'],
        predictability: json['predictability'],
        theTemp: json['the_temp'],
        visibility: json['visibility'],
        weatherStateAbbr: json['weather_state_abbr'],
        weatherStateName: _jsonToEnumWeatherState(json['weather_state_name']),
        windDirection: json['wind_direction'],
        windDirectionCompass:
            _jsonToEnumWindDirectionCompass(json['wind_direction_compass']),
        windSpeed: json['wind_speed'],
      );

  Map<String, dynamic> toJson() => {
        'air_pressure': airPressure,
        'applicable_date': applicableDate.toString(),
        'created': created.toIso8601String(),
        'humidity': humidity,
        'id': id,
        'max_temp': maxTemp,
        'min_temp': minTemp,
        'predictability': predictability,
        'the_temp': theTemp,
        'visibility': visibility,
        'weather_state_abbr': weatherStateAbbr,
        'weather_state_name': _enumToJsonWeatherState(weatherStateName),
        'wind_direction': windDirection,
        'wind_direction_compass':
            _enumToStringWindDirectionCompass(windDirectionCompass),
        'wind_speed': windSpeed,
      };
}

WeatherState _jsonToEnumWeatherState(String data) {
  switch (data) {
    case 'Clear':
      return WeatherState.clear;
    case 'Snow':
      return WeatherState.snow;
    case 'Sleet':
      return WeatherState.sleet;
    case 'Hall':
      return WeatherState.hall;
    case 'Thunderstorm':
      return WeatherState.thunderstorm;
    case 'Heavy Rain':
      return WeatherState.heavyRain;
    case 'Light Rain':
      return WeatherState.lightRain;
    case 'Showers':
      return WeatherState.showers;
    case 'Heavy Cloud':
      return WeatherState.heavyCloud;
    case 'Light Cloud':
      return WeatherState.lightCloud;
    default:
      return WeatherState.unknown;
  }
}

String? _enumToJsonWeatherState(WeatherState state) {
  switch (state) {
    case WeatherState.clear:
      return 'Clear';
    case WeatherState.hall:
      return 'Hall';
    case WeatherState.heavyCloud:
      return 'Heavy Cloud';
    case WeatherState.heavyRain:
      return 'Heavy Rain';
    case WeatherState.lightCloud:
      return 'Light Cloud';
    case WeatherState.lightRain:
      return 'Ligh Rain';
    case WeatherState.showers:
      return 'Showers';
    case WeatherState.sleet:
      return 'Sleet';
    case WeatherState.snow:
      return 'Snow';
    case WeatherState.thunderstorm:
      return 'Thunderstorm';
    default:
      return null;
  }
}

WindDirectionCompass _jsonToEnumWindDirectionCompass(String data) {
  switch (data) {
    case 'North':
      return WindDirectionCompass.north;
    case 'NorthEast':
      return WindDirectionCompass.northEast;
    case 'East':
      return WindDirectionCompass.east;
    case 'SouthEast':
      return WindDirectionCompass.southEast;
    case 'south':
      return WindDirectionCompass.south;
    case 'SouthWest':
      return WindDirectionCompass.southWest;
    case 'West':
      return WindDirectionCompass.west;
    case 'NorthWest':
      return WindDirectionCompass.northWest;
    default:
      return WindDirectionCompass.unknown;
  }
}

String? _enumToStringWindDirectionCompass(WindDirectionCompass compass) {
  switch (compass) {
    case WindDirectionCompass.east:
      return 'East';
    case WindDirectionCompass.north:
      return 'North';
    case WindDirectionCompass.northEast:
      return 'NothEast';
    case WindDirectionCompass.south:
      return 'South';
    case WindDirectionCompass.southEast:
      return 'SouthEast';
    case WindDirectionCompass.southWest:
      return 'SouthWest';
    case WindDirectionCompass.west:
      return 'West';

    default:
      return null;
  }
}
