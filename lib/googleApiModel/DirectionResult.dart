import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/GeocodedWaypoint.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Route.dart';

part 'DirectionResult.g.dart';

@JsonSerializable()
class DirectionResult {
  @JsonKey(name: "geocoded_waypoints")
  List<GeocodedWaypoint>? geocodedWaypoints;

  DirectionResultStatus? status;
  List<Route>? routes;

  DirectionResult();

  factory DirectionResult.fromJson(Map<String, dynamic> json) => _$DirectionResultFromJson(json);

  Map<String, dynamic> toJson() => _$DirectionResultToJson(this);
}

enum DirectionResultStatus {
  OK,
  NOT_FOUND,
  ZERO_RESULTS,
  MAX_WAYPOINTS_EXCEEDED,
  MAX_ROUTE_LENGTH_EXCEEDED,
  INVALID_REQUEST,
  OVER_DAILY_LIMIT,
  OVER_QUERY_LIMIT,
  REQUEST_DENIED,
  UNKNOWN_ERROR
}
