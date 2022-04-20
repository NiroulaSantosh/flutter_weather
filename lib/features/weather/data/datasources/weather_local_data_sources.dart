// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter_weather/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather_model.dart';

const String CACHED_WEATHER = 'cached_wwather';

abstract class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeather();
  Future<void> cachedWeather(WeatherModel weather);
}

class WeatherLocalDataSourcesImpl extends WeatherLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourcesImpl({required this.sharedPreferences});

  @override
  Future<void> cachedWeather(WeatherModel weather) async {
    await sharedPreferences.setString(
        CACHED_WEATHER, jsonEncode(weather.toJson()));
  }

  @override
  Future<WeatherModel> getLastWeather() async {
    final jsonString = sharedPreferences.getString(CACHED_WEATHER);
    if (jsonString == null) {
      throw CacheException();
    } else {
      return WeatherModel.fromJson(jsonDecode(jsonString));
    }
  }
}
