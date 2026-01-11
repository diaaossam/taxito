import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final double lat;
  final double lon;
  final String address;

  const LocationEntity(
      {required this.lat, required this.lon, required this.address});

  @override
  List<Object> get props => [lat, lon, address];
}
