// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direction_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectionResult _$DirectionResultFromJson(Map<String, dynamic> json) =>
    DirectionResult()
      ..geocodedWaypoints = (json['geocoded_waypoints'] as List<dynamic>?)
          ?.map((e) => GeocodedWaypoint.fromJson(e as Map<String, dynamic>))
          .toList()
      ..status =
          $enumDecodeNullable(_$DirectionResultStatusEnumMap, json['status'])
      ..routes = (json['routes'] as List<dynamic>?)
          ?.map((e) => Route.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DirectionResultToJson(DirectionResult instance) =>
    <String, dynamic>{
      'geocoded_waypoints': instance.geocodedWaypoints,
      'status': _$DirectionResultStatusEnumMap[instance.status],
      'routes': instance.routes,
    };

const _$DirectionResultStatusEnumMap = {
  DirectionResultStatus.OK: 'OK',
  DirectionResultStatus.NOT_FOUND: 'NOT_FOUND',
  DirectionResultStatus.ZERO_RESULTS: 'ZERO_RESULTS',
  DirectionResultStatus.MAX_WAYPOINTS_EXCEEDED: 'MAX_WAYPOINTS_EXCEEDED',
  DirectionResultStatus.MAX_ROUTE_LENGTH_EXCEEDED: 'MAX_ROUTE_LENGTH_EXCEEDED',
  DirectionResultStatus.INVALID_REQUEST: 'INVALID_REQUEST',
  DirectionResultStatus.OVER_DAILY_LIMIT: 'OVER_DAILY_LIMIT',
  DirectionResultStatus.OVER_QUERY_LIMIT: 'OVER_QUERY_LIMIT',
  DirectionResultStatus.REQUEST_DENIED: 'REQUEST_DENIED',
  DirectionResultStatus.UNKNOWN_ERROR: 'UNKNOWN_ERROR',
};
