// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class LocationUser extends Equatable {
  final double lat;
  final double long;
  const LocationUser({
    required this.lat,
    required this.long,
  });
  @override
  List<Object> get props => [lat, long];

  LocationUser copyWith({
    double? lat,
    double? long,
  }) {
    return LocationUser(
      lat: lat ?? this.lat,
      long: long ?? this.long,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lat': lat,
      'long': long,
    };
  }

  factory LocationUser.fromMap(Map<String, dynamic> map) {
    return LocationUser(
      lat: map['lat'] as double,
      long: map['long'] as double,
    );
  }
}
