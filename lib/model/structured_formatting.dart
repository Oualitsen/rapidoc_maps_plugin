import 'package:json_annotation/json_annotation.dart';
import 'package:rapidoc_maps_plugin/model/term.dart';

part 'structured_formatting.g.dart';

@JsonSerializable()
class StructuredFormatting {
  @JsonKey(name: "main_text")
  String? mainText;

  @JsonKey(name: "secondary_text")
  String? secondaryText;

  @JsonKey(name: "main_text_matched_substrings")
  List<Term>? mainTextMatchedSubstrings;

  StructuredFormatting(this.mainText, this.secondaryText);

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}
