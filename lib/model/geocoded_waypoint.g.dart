// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoded_waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodedWaypoint _$GeocodedWaypointFromJson(Map<String, dynamic> json) =>
    GeocodedWaypoint()
      ..status =
          $enumDecodeNullable(_$GeocodedWaypointStatusEnumMap, json['status'])
      ..placeId = json['placeId'] as String?
      ..types =
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$GeocodedWaypointToJson(GeocodedWaypoint instance) =>
    <String, dynamic>{
      'status': _$GeocodedWaypointStatusEnumMap[instance.status],
      'placeId': instance.placeId,
      'types': instance.types,
    };

const _$GeocodedWaypointStatusEnumMap = {
  GeocodedWaypointStatus.OK: 'OK',
  GeocodedWaypointStatus.ZERO_RESULTS: 'ZERO_RESULTS',
};
