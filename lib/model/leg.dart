import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/model/step.dart';
import 'package:rapidoc_maps_plugin/model/text_value.dart';
import 'package:rapidoc_maps_plugin/model/lat_lng.dart';
part 'leg.g.dart';

@JsonSerializable()
class Leg {
  TextValue? distance;
  TextValue? duration;

  @JsonKey(name: "start_address")
  String? startAddress;

  @JsonKey(name: "end_address")
  String? endAddress;

  @JsonKey(name: "start_location")
  LatLng? startLocation;

  @JsonKey(name: "end_location")
  LatLng? endLocation;

  List<Step>? steps;

  Leg();

  factory Leg.fromJson(Map<String, dynamic> json) => _$LegFromJson(json);

  Map<String, dynamic> toJson() => _$LegToJson(this);
}
