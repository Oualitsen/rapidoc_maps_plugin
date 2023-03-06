import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/model/coords.dart';

part 'bounds.g.dart';

@JsonSerializable()
class Bounds {
  Coords? northeast;
  Coords? southwest;
  Bounds();

  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);

  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}
