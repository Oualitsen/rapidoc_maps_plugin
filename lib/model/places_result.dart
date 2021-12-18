import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/model/prediction.dart';
import 'package:rapidoc_maps_plugin/model/response_status.dart';

part 'places_result.g.dart';

@JsonSerializable()
class PlacesResult {
  @JsonKey(defaultValue: const [])
  List<Prediction> predictions = [];
  ResponseStatus? status;

  PlacesResult();

  factory PlacesResult.fromJson(Map<String, dynamic> json) =>
      _$PlacesResultFromJson(json);
  Map<String, dynamic> toJson() => _$PlacesResultToJson(this);
}
