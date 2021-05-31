import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Step.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/TextValue.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/LatLng.dart';
part 'Leg.g.dart';

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
