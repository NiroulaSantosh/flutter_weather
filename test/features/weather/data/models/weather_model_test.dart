import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/features/weather/data/models/weather_model.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';

import '../../../../fixtures/filxture_reader.dart';

void main() {
  final tWeatherModel = WeatherModel(
    airPressure: 1023.0,
    applicableDate: DateTime.parse("2021-05-28"),
    created: DateTime.parse('2021-05-28T15:32:01.902125Z'),
    humidity: 57,
    id: 5037922198749184,
    maxTemp: 19.375,
    minTemp: 9.61,
    predictability: 71,
    theTemp: 18.54,
    visibility: 10.56983466555317,
    weatherStateAbbr: "hc",
    weatherStateName: WeatherState.heavyCloud,
    windDirection: 148.63313166521016,
    windDirectionCompass: WindDirectionCompass.unknown,
    windSpeed: 3.0192401717198227,
  );

  group('fromJson', () {
    test('should correctely convert the data', () {
      final json = jsonDecode(readFile('weather_model.json'));
      final convertedData = WeatherModel.fromJson(json);
      expect(convertedData, equals(tWeatherModel));
    });
  });

  group('toJson', () {
    test('should convert data to json correctely', () {
      final convertedJson = tWeatherModel.toJson();
      final json = {
        "id": 5037922198749184,
        "weather_state_name": "Heavy Cloud",
        "weather_state_abbr": "hc",
        "wind_direction_compass": null,
        "created": "2021-05-28T15:32:01.902125Z",
        "applicable_date": "2021-05-28 00:00:00.000",
        "min_temp": 9.61,
        "max_temp": 19.375,
        "the_temp": 18.54,
        "wind_speed": 3.0192401717198227,
        "wind_direction": 148.63313166521016,
        "air_pressure": 1023.0,
        "humidity": 57,
        "visibility": 10.56983466555317,
        "predictability": 71
      };

      expect(convertedJson, equals(json));
    });
  });
}
