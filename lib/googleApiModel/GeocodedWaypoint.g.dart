// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GeocodedWaypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodedWaypoint _$GeocodedWaypointFromJson(Map<String, dynamic> json) {
  return GeocodedWaypoint()
    ..status =
        _$enumDecodeNullable(_$GeocodedWaypointStatusEnumMap, json['status'])
    ..placeId = json['placeId'] as String?
    ..types =
        (json['types'] as List<dynamic>?)?.map((e) => e as String).toList();
}

Map<String, dynamic> _$GeocodedWaypointToJson(GeocodedWaypoint instance) =>
    <String, dynamic>{
      'status': _$GeocodedWaypointStatusEnumMap[instance.status],
      'placeId': instance.placeId,
      'types': instance.types,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$GeocodedWaypointStatusEnumMap = {
  GeocodedWaypointStatus.OK: 'OK',
  GeocodedWaypointStatus.ZERO_RESULTS: 'ZERO_RESULTS',
};
