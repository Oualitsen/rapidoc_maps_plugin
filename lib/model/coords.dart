import 'package:json_annotation/json_annotation.dart';
part 'coords.g.dart';

@JsonSerializable()
class Coords {
  double lat = 0;
  double lng = 0;

  Coords({required this.lat, required this.lng});

  factory Coords.fromJson(Map<String, dynamic> json) => _$CoordsFromJson(json);
  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}
