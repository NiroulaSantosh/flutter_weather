// [{"title":"London","location_type":"City","woeid":44418,"latt_long":"51.506321,-0.12714"}]

// 	(City|Region / State / Province|Country|Continent)

// ignore_for_file: constant_identifier_names

import 'package:equatable/equatable.dart';

enum LocationType {
  City,
  Region,
  Country,
  Continent,
  None,
}

class Location extends Equatable {
  final String? title;
  final LocationType? locationType;
  final String? lattLong;
  final int? woeid;
  final int? distance;

  const Location({
    this.title,
    this.locationType,
    this.lattLong,
    this.woeid,
    this.distance,
  });

  @override
  List<Object?> get props => [
        title,
        locationType,
        lattLong,
        woeid,
        distance,
      ];
}
