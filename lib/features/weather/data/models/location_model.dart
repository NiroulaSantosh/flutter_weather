import '../../domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel(
      {int? distance,
      String? lattLong,
      LocationType? locationType,
      String? title,
      int? woeid})
      : super(
            distance: distance,
            lattLong: lattLong,
            locationType: locationType,
            title: title,
            woeid: woeid);

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        distance: json['distance'],
        lattLong: json['latt_long'],
        locationType: _jsonToEnum(json['location_type']),
        title: json['title'],
        woeid: json['woeid'],
      );

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'latt_long': lattLong,
        'location_type': _enumToJSon(locationType),
        'title': title,
        'woeid': woeid,
      };
}

LocationType? _jsonToEnum(String? data) {
  if (data == null) {
    return null;
  } else {
    switch (data) {
      case 'City':
        return LocationType.City;
      case 'Continent':
        return LocationType.Continent;
      case 'Country':
        return LocationType.Country;
      case 'Region':
        return LocationType.Region;
      default:
        return LocationType.None;
    }
  }
}

String? _enumToJSon(LocationType? type) {
  if (type == null) {
    return null;
  } else {
    switch (type) {
      case LocationType.City:
        return 'City';
      case LocationType.Continent:
        return 'Continent';
      case LocationType.Country:
        return 'Country';
      case LocationType.Region:
        return 'Region';
      default:
        return null;
    }
  }
}
