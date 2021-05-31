import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/LatLng.dart';

part 'Bounds.g.dart';

@JsonSerializable()
class Bounds {
  LatLng? northeast;
  LatLng? southwest;
  Bounds();

  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);

  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}
