import 'package:json_annotation/json_annotation.dart';

part 'GeocodedWaypoint.g.dart';

@JsonSerializable()
class GeocodedWaypoint {
  GeocodedWaypointStatus? status;
  String? placeId;
  List<String>? types;
  GeocodedWaypoint();

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) => _$GeocodedWaypointFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodedWaypointToJson(this);
}

enum GeocodedWaypointStatus { OK, ZERO_RESULTS }
