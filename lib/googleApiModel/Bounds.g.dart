// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Bounds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bounds _$BoundsFromJson(Map<String, dynamic> json) {
  return Bounds()
    ..northeast = json['northeast'] == null
        ? null
        : LatLng.fromJson(json['northeast'] as Map<String, dynamic>)
    ..southwest = json['southwest'] == null
        ? null
        : LatLng.fromJson(json['southwest'] as Map<String, dynamic>);
}

Map<String, dynamic> _$BoundsToJson(Bounds instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };
