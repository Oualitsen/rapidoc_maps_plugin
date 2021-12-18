import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/model/bounds.dart';
import 'package:rapidoc_maps_plugin/model/leg.dart';

part 'route.g.dart';

@JsonSerializable()
class Route {
  String? copyrights;
  Bounds? bounds;
  List<Leg>? legs;

  Route();

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}
