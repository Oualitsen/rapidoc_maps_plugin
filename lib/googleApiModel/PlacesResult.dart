import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Prediction.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/ResponseStatus.dart';

part 'PlacesResult.g.dart';

@JsonSerializable()
class PlacesResult {
  @JsonKey(defaultValue: const [])
  List<Prediction> predictions = [];
  ResponseStatus? status;

  PlacesResult();

  factory PlacesResult.fromJson(Map<String, dynamic> json) => _$PlacesResultFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesResultToJson(this);
}
