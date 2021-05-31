import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Bounds.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Leg.dart';

part 'Route.g.dart';

@JsonSerializable()
class Route {
  String? copyrights;
  Bounds? bounds;
  List<Leg>? legs;

  Route();

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}
