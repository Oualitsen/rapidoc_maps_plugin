import 'package:json_annotation/json_annotation.dart';

part 'polyline.g.dart';

@JsonSerializable()
class Polyline {
  String? points;
  Polyline();

  factory Polyline.fromJson(Map<String, dynamic> json) =>
      _$PolylineFromJson(json);

  Map<String, dynamic> toJson() => _$PolylineToJson(this);
}
