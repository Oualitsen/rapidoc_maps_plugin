// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coords.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coords _$CoordsFromJson(Map<String, dynamic> json) => Coords(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$CoordsToJson(Coords instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
