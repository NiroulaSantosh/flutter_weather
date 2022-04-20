import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/features/weather/data/models/location_model.dart';
import 'package:flutter_weather/features/weather/domain/entities/location.dart';

import '../../../../fixtures/filxture_reader.dart';

void main() {
  const tLocationModel = LocationModel(
      title: 'London',
      locationType: LocationType.City,
      lattLong: '51.506321,-0.12714',
      woeid: 44418);

  test('should be subclass of Location', () {
    expect(tLocationModel, isA<Location>());
  });

  group('fromJson', () {
    test('should return proper LocationModel', () {
      final json = jsonDecode(readFile('location_model.json'));
      final convertedData = LocationModel.fromJson(json);
      expect(convertedData, tLocationModel);
    });
  });

  group('toJson', () {
    test('should return proper jsonData', () {
      final convetedData = tLocationModel.toJson();
      final actualData = {
        "title": "London",
        "location_type": "City",
        "woeid": 44418,
        "latt_long": "51.506321,-0.12714",
        'distance': null,
      };
      expect(actualData, equals(convetedData));
    });
  });
}
