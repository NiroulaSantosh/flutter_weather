import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/core/error/exception.dart';
import 'package:flutter_weather/core/error/failure.dart';
import 'package:flutter_weather/core/platform/network_info.dart';
import 'package:flutter_weather/features/weather/data/datasources/weather_local_data_sources.dart';
import 'package:flutter_weather/features/weather/data/datasources/weather_remote_data_sources.dart';
import 'package:flutter_weather/features/weather/data/models/location_model.dart';
import 'package:flutter_weather/features/weather/data/models/weather_model.dart';
import 'package:flutter_weather/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_repository_impl_test.mocks.dart';

@GenerateMocks([NetworkInfo, WeatherRemoteDataSources, WeatherLocalDataSource])
void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockWeatherLocalDataSource mockWeatherLocalDataSource;
  late MockWeatherRemoteDataSources mockWeatherRemoteDataSources;
  late WeatherRepositoryImpl repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockWeatherLocalDataSource = MockWeatherLocalDataSource();
    mockWeatherRemoteDataSources = MockWeatherRemoteDataSources();
    repository = WeatherRepositoryImpl(
        remoteDataSources: mockWeatherRemoteDataSources,
        localDataSource: mockWeatherLocalDataSource,
        networkInfo: mockNetworkInfo);
  });

  group('RemoteDataSources', () {
    group(' LocationInfromation', () {
      const String tLocationString = 'Test Location';
      const tLocation = LocationModel();

      test(' should check the network information', () {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);

        when(mockWeatherRemoteDataSources.getLocationInformation(any))
            .thenAnswer((realInvocation) async => tLocation);

        repository.getLocationInformation(tLocationString);

        verify(mockNetworkInfo.isConnected);
      });

      group(' device is Online', () {
        test(' should return Location data on success', () async {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true);

          when(mockWeatherRemoteDataSources.getLocationInformation(any))
              .thenAnswer((realInvocation) async => tLocation);

          final result =
              await repository.getLocationInformation(tLocationString);

          verify(mockWeatherRemoteDataSources
              .getLocationInformation(tLocationString));

          expect(result, equals(const Right(tLocation)));
        });
      });

      group('device is offline', () {
        setUp(() {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => false);
        });

        test('should return ServerFailure ', () async {
          when(mockWeatherRemoteDataSources.getLocationInformation(any))
              .thenThrow(ServerException());

          final result =
              await repository.getLocationInformation(tLocationString);

          expect(result, equals(const Left(ServerFailure())));
        });
      });
    });

    group(' WeatherInformation', () {
      const int tWoeid = 123;
      final tWeather = WeatherModel(
          airPressure: 1.0,
          applicableDate: DateTime.now(),
          created: DateTime.now(),
          humidity: 1,
          id: 1,
          maxTemp: 1.2,
          minTemp: 1.3,
          predictability: 1,
          theTemp: 2.6,
          visibility: 1.6,
          weatherStateAbbr: '1h',
          weatherStateName: WeatherState.clear,
          windDirection: 27.5,
          windDirectionCompass: WindDirectionCompass.east,
          windSpeed: 27.5);

      test('should check internet connection', () {
        when(mockNetworkInfo.isConnected)
            .thenAnswer((realInvocation) async => true);

        when(mockWeatherRemoteDataSources.getWeatherData(any))
            .thenAnswer((realInvocation) async => tWeather);
        repository.getWeatherData(tWoeid);

        verify(mockNetworkInfo.isConnected);
      });

      group('Device is online', () {
        setUp(() {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => true);
        });

        test('should get weather data on success', () async {
          when(mockWeatherRemoteDataSources.getWeatherData(any))
              .thenAnswer((realInvocation) async => tWeather);
          final result = await repository.getWeatherData(tWoeid);

          expect(result, equals(Right(tWeather)));
        });

        test('should cached the data on success', () async {
          when(mockWeatherRemoteDataSources.getWeatherData(any))
              .thenAnswer((realInvocation) async => tWeather);

          when(mockWeatherLocalDataSource.cachedWeather(any));

          await repository.getWeatherData(tWoeid);

          verify(mockWeatherLocalDataSource.cachedWeather(tWeather));
        });

        test('should return ServerFailue on unsuccess', () async {
          when(mockWeatherRemoteDataSources.getWeatherData(any))
              .thenThrow(ServerException());

          final call = await repository.getWeatherData(tWoeid);

          verifyZeroInteractions(mockWeatherLocalDataSource);
          expect(call, equals(const Left(ServerFailure())));
        });
      });

      group('Device is offline', () {
        setUp(() {
          when(mockNetworkInfo.isConnected)
              .thenAnswer((realInvocation) async => false);
        });

        test('should return data from local cached if data present', () async {
          when(mockWeatherLocalDataSource.getLastWeather())
              .thenAnswer((realInvocation) async => tWeather);

          final result = await repository.getWeatherData(tWoeid);

          verifyZeroInteractions(mockWeatherRemoteDataSources);
          verify(mockWeatherLocalDataSource.getLastWeather());
          expect(result, equals(Right(tWeather)));
        });

        test('should return cached faiure on exception', () async {
          when(mockWeatherLocalDataSource.getLastWeather())
              .thenThrow(CacheException());
          final result = await repository.getWeatherData(tWoeid);

          expect(result, equals(const Left(CacheFailure())));
        });
      });
    });
  });
}
