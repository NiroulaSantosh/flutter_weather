import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/features/weather/domain/entities/location.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location_weather.dart';
import 'package:flutter_weather/features/weather/presentation/bloc/blocs.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_bloc_test.mocks.dart';

@GenerateMocks([GetLocation, GetLocationWeather])
void main() {
  late MockGetLocation mockGetLocation;
  late MockGetLocationWeather mockGetLocationWeather;
  late WeatherBloc bloc;

  setUp(() {
    mockGetLocation = MockGetLocation();
    mockGetLocationWeather = MockGetLocationWeather();
    bloc =
        WeatherBloc(location: mockGetLocation, weather: mockGetLocationWeather);
  });

  test('inital state should be [WeatherInitial]', () {
    expect(bloc.state, equals(WeatherInitial()));
  });

  group('GetWeatherForLocation', () {
    const tLocation = Location();
    const tLocationString = 'Test Location';
    test('should call the GetLocationInfo', () async {
      when(mockGetLocation(any))
          .thenAnswer((realInvocation) async => const Right(tLocation));

      bloc.add(const GetWeatherForLocation(location: tLocationString));

      await untilCalled(mockGetLocation(any));

      verify(mockGetLocation(StringParam(location: tLocationString)));
    });
  });
}
