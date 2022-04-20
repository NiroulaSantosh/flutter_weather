import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/core/error/exception.dart';
import 'package:flutter_weather/features/weather/data/datasources/weather_remote_data_sources.dart';
import 'package:flutter_weather/features/weather/data/models/location_model.dart';
import 'package:flutter_weather/features/weather/data/models/weather_model.dart';
import 'package:flutter_weather/features/weather/domain/entities/location.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/filxture_reader.dart';
import 'weather_remote_data_sources_test.mocks.dart';

@GenerateMocks([Client])
void main() {
  late MockClient mockClient;
  late WeatherRemoteDateSourcesImpl weatherRemoteDateSourcesImpl;

  setUp(() {
    mockClient = MockClient();
    weatherRemoteDateSourcesImpl = WeatherRemoteDateSourcesImpl(mockClient);
  });

  group('getLocationInformation', () {
    const tLocationString = 'Test Location';
    const tLocationModel = LocationModel(
        title: 'London',
        locationType: LocationType.City,
        lattLong: '51.506321,-0.12714',
        woeid: 44418);

    void setupSuccessfulApiCall() {
      when(mockClient.get(any)).thenAnswer((realInvocation) async =>
          Response(readFile('location_model.json'), 200));
    }

    test('should call the get request', () async {
      setupSuccessfulApiCall();

      weatherRemoteDateSourcesImpl.getLocationInformation(tLocationString);

      verify(mockClient.get(Uri.parse(
          'https://www.metaweather.com/api/location/search/?query=$tLocationString')));
    });
    test('should retrun valid data on sucessfull call', () async {
      setupSuccessfulApiCall();

      final result = await weatherRemoteDateSourcesImpl
          .getLocationInformation(tLocationString);

      expect(result, equals(tLocationModel));
    });

    test('should throw server excpetion on status code except from 200',
        () async {
      when(mockClient.get(any))
          .thenAnswer((realInvocation) async => Response('', 400));
      final call = weatherRemoteDateSourcesImpl.getLocationInformation;

      expect(() => call(tLocationString),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getLocationWeather', () {
    const woeid = 123;
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

    void setupSucessfullResponse() {
      when(mockClient.get(any)).thenAnswer(
          (realInvocation) async => Response(readFile('weather.json'), 200));
    }

    test('should call the get request', () async {
      setupSucessfullResponse();
      await weatherRemoteDateSourcesImpl.getWeatherData(woeid);
      verify(mockClient
          .get(Uri.parse('https://www.metaweather.com/api/location/$woeid/')));
    });

    test('should return correct data on successfull response', () async {
      setupSucessfullResponse();
      final result = await weatherRemoteDateSourcesImpl.getWeatherData(woeid);

      expect(result, equals(tWeatherModel));
    });

    test('should throw server excpetion on status code except from 200',
        () async {
      when(mockClient.get(any))
          .thenAnswer((realInvocation) async => Response('', 400));
      final call = weatherRemoteDateSourcesImpl.getWeatherData;

      expect(() => call(woeid), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
