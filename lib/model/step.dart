import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/model/text_value.dart';
import 'package:rapidoc_maps_plugin/model/coords.dart';
import 'package:rapidoc_maps_plugin/model/polyline.dart';

part 'step.g.dart';

@JsonSerializable()
class Step {
  TextValue? distance;
  TextValue? duration;
  @JsonKey(name: "start_location")
  Coords? startLocation;

  @JsonKey(name: "end_location")
  Coords? endLocation;

  Polyline? polyline;

  @JsonKey(name: "html_instructions")
  String? htmlInstructions;

  @JsonKey(name: "travel_mode")
  String? travelMode;

  Step();

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  Map<String, dynamic> toJson() => _$StepToJson(this);
}
