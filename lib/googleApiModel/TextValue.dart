import 'package:json_annotation/json_annotation.dart';

part 'TextValue.g.dart';

@JsonSerializable()
class TextValue {
  String? text;
  int? value;
  bool? distance;
  TextValue();

  factory TextValue.fromJson(Map<String, dynamic> json) => _$TextValueFromJson(json);

  Map<String, dynamic> toJson() => _$TextValueToJson(this);
}
