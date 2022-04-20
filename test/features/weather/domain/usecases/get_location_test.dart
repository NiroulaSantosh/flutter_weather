import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/features/weather/domain/entities/location.dart';
import 'package:flutter_weather/features/weather/domain/repositories/weather_repository.dart';
import 'package:flutter_weather/features/weather/domain/usecases/get_location.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_location_test.mocks.dart';

@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository mockWeatherRepository;
  late GetLocation getLocation;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getLocation = GetLocation(repository: mockWeatherRepository);
  });

  group('GetLocarion use case ', () {
    const String tLocationString = 'Test Location';
    const tLocation = Location(
      distance: 2,
      title: 'Test Location',
      woeid: 12345,
    );

    test('should call the getLocation function', () async {
      when(mockWeatherRepository.getLocationInformation(any))
          .thenAnswer((realInvocation) async => const Right(tLocation));

      await getLocation(StringParam(location: tLocationString));

      verify(mockWeatherRepository.getLocationInformation(tLocationString));
    });

    test('shoud get corret location data', () async {
      when(mockWeatherRepository.getLocationInformation(any))
          .thenAnswer((realInvocation) async => const Right(tLocation));

      final result = await getLocation(StringParam(location: tLocationString));

      expect(result, equals(const Right(tLocation)));
    });
  });
}
