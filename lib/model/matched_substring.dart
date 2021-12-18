import 'package:json_annotation/json_annotation.dart';

part 'matched_substring.g.dart';

@JsonSerializable()
class MatchedSubstring {
  int length = 0;
  int offset = 0;

  MatchedSubstring();

  factory MatchedSubstring.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedSubstringToJson(this);
}
