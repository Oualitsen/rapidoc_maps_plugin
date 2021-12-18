import 'package:json_annotation/json_annotation.dart';
part 'lat_lng.g.dart';

@JsonSerializable()
class LatLng {
  double lat = 0;
  double lng = 0;

  LatLng({required this.lat, required this.lng});

  factory LatLng.fromJson(Map<String, dynamic> json) => _$LatLngFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngToJson(this);
}
