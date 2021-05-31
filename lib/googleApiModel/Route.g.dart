// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) {
  return Route()
    ..copyrights = json['copyrights'] as String?
    ..bounds = json['bounds'] == null
        ? null
        : Bounds.fromJson(json['bounds'] as Map<String, dynamic>)
    ..legs = (json['legs'] as List<dynamic>?)
        ?.map((e) => Leg.fromJson(e as Map<String, dynamic>))
        .toList();
}

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'copyrights': instance.copyrights,
      'bounds': instance.bounds,
      'legs': instance.legs,
    };
