import 'dart:convert';

import 'package:http/http.dart';

import '../../../../core/error/exception.dart';
import '../models/location_model.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSources {
  Future<LocationModel> getLocationInformation(String location);
  Future<WeatherModel> getWeatherData(int woeid);
}

class WeatherRemoteDateSourcesImpl extends WeatherRemoteDataSources {
  final Client client;
  WeatherRemoteDateSourcesImpl(this.client);
  @override
  Future<LocationModel> getLocationInformation(String location) async {
    final response = await client.get(Uri.parse(
        'https://www.metaweather.com/api/location/search/?query=$location'));

    if (response.statusCode == 200) {
      return LocationModel.fromJson(jsonDecode(response.body).first);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<WeatherModel> getWeatherData(int woeid) async {
    final response = await client
        .get(Uri.parse('https://www.metaweather.com/api/location/$woeid/'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(
          jsonDecode(response.body)['consolidated_weather'].first);
    } else {
      throw ServerException();
    }
  }
}
