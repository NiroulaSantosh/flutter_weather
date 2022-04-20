import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/core/error/exception.dart';
import 'package:flutter_weather/features/weather/data/datasources/weather_local_data_sources.dart';
import 'package:flutter_weather/features/weather/data/models/weather_model.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/filxture_reader.dart';
import 'weather_local_data_sources_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late WeatherLocalDataSourcesImpl weatherLocalDataSourcesImpl;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();

    weatherLocalDataSourcesImpl =
        WeatherLocalDataSourcesImpl(sharedPreferences: mockSharedPreferences);
  });

  group('cachedWeather', () {
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

    test('should add data to shared preference', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((realInvocation) async => Future.value(true));

      weatherLocalDataSourcesImpl.cachedWeather(tWeatherModel);

      verify(mockSharedPreferences.setString(
          CACHED_WEATHER, jsonEncode(tWeatherModel.toJson())));
    });

    test('should return data from sharedprefeneces', () async {
      when(mockSharedPreferences.getString(any))
          .thenReturn(readFile('weather_model.json'));

      final result = await weatherLocalDataSourcesImpl.getLastWeather();

      expect(result, equals(tWeatherModel));
    });

    test('should throw CachedExption on error', () {
      when(mockSharedPreferences.getString(any)).thenThrow(CacheException());

      final call = weatherLocalDataSourcesImpl.getLastWeather;

      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });
}
