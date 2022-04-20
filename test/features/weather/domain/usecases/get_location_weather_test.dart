import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/features/weather/domain/entities/weather.dart';
import 'package:flutter_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_location_weather_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetLocationWeather getLocationWeather;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getLocationWeather = GetLocationWeather(repository: mockWeatherRepository);
  });

  group('GetLocationWeather', () {
    const tWoeid = 1;
    final tWeather = Weather(
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

    test(' Make sure the is called', () {
      when(mockWeatherRepository.getWeatherData(any))
          .thenAnswer((realInvocation) async => Right(tWeather));

      getLocationWeather(const IntegerParams(woeid: tWoeid));

      verify(mockWeatherRepository.getWeatherData(tWoeid));
    });

    test('should return the weather data correctely on success', () async {
      when(mockWeatherRepository.getWeatherData(any))
          .thenAnswer((realInvocation) async => Right(tWeather));

      final result =
          await getLocationWeather(const IntegerParams(woeid: tWoeid));

      expect(result, equals(Right(tWeather)));
    });
  });
}
