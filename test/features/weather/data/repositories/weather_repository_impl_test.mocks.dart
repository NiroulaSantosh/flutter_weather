// Mocks generated by Mockito 5.1.0 from annotations
// in flutter_weather/test/features/weather/data/repositories/weather_repository_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:flutter_weather/core/platform/network_info.dart' as _i4;
import 'package:flutter_weather/features/weather/data/datasources/weather_local_data_sources.dart'
    as _i7;
import 'package:flutter_weather/features/weather/data/datasources/weather_remote_data_sources.dart'
    as _i6;
import 'package:flutter_weather/features/weather/data/models/location_model.dart'
    as _i2;
import 'package:flutter_weather/features/weather/data/models/weather_model.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeLocationModel_0 extends _i1.Fake implements _i2.LocationModel {}

class _FakeWeatherModel_1 extends _i1.Fake implements _i3.WeatherModel {}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i4.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  List<Object?> get props =>
      (super.noSuchMethod(Invocation.getter(#props), returnValue: <Object?>[])
          as List<Object?>);
}

/// A class which mocks [WeatherRemoteDataSources].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherRemoteDataSources extends _i1.Mock
    implements _i6.WeatherRemoteDataSources {
  MockWeatherRemoteDataSources() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.LocationModel> getLocationInformation(String? location) =>
      (super.noSuchMethod(
              Invocation.method(#getLocationInformation, [location]),
              returnValue:
                  Future<_i2.LocationModel>.value(_FakeLocationModel_0()))
          as _i5.Future<_i2.LocationModel>);
  @override
  _i5.Future<_i3.WeatherModel> getWeatherData(int? woeid) =>
      (super.noSuchMethod(Invocation.method(#getWeatherData, [woeid]),
              returnValue:
                  Future<_i3.WeatherModel>.value(_FakeWeatherModel_1()))
          as _i5.Future<_i3.WeatherModel>);
}

/// A class which mocks [WeatherLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockWeatherLocalDataSource extends _i1.Mock
    implements _i7.WeatherLocalDataSource {
  MockWeatherLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i3.WeatherModel> getLastWeather() => (super.noSuchMethod(
          Invocation.method(#getLastWeather, []),
          returnValue: Future<_i3.WeatherModel>.value(_FakeWeatherModel_1()))
      as _i5.Future<_i3.WeatherModel>);
  @override
  _i5.Future<void> cachedWeather(_i3.WeatherModel? weather) =>
      (super.noSuchMethod(Invocation.method(#cachedWeather, [weather]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
}