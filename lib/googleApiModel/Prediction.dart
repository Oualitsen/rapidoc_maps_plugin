import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/MatchedSubstring.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/Term.dart';
import 'package:rapidoc_maps_plugin/googleApiModel/StructuredFormatting.dart';

part 'Prediction.g.dart';

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

  factory Prediction.fromJson(Map<String, dynamic> json) => _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
}
