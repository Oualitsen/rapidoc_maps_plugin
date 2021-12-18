import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/model/matched_substring.dart';
import 'package:rapidoc_maps_plugin/model/term.dart';
import 'package:rapidoc_maps_plugin/model/structured_formatting.dart';

part 'prediction.g.dart';

@JsonSerializable()
class Prediction {
  String? description;
  String? id;

  @JsonKey(name: "matched_substrings", defaultValue: [])
  List<MatchedSubstring> matchedSubStrings = <MatchedSubstring>[];

  @JsonKey(name: "place_id")
  String? placeId;

  String? reference;

  @JsonKey(name: "structured_formatting")
  StructuredFormatting? structuredFormatting;

  List<Term>? terms;

  List<String>? types;

  Prediction();

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}
