// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesResult _$PlacesResultFromJson(Map<String, dynamic> json) {
  return PlacesResult()
    ..predictions = (json['predictions'] as List<dynamic>?)
            ?.map((e) => Prediction.fromJson(e as Map<String, dynamic>))
            .toList() ??
        []
    ..status = _$enumDecodeNullable(_$ResponseStatusEnumMap, json['status']);
}

Map<String, dynamic> _$PlacesResultToJson(PlacesResult instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
      'status': _$ResponseStatusEnumMap[instance.status],
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

const _$ResponseStatusEnumMap = {
  ResponseStatus.OK: 'OK',
  ResponseStatus.INVALID_REQUEST: 'INVALID_REQUEST',
  ResponseStatus.MAX_ELEMENTS_EXCEEDED: 'MAX_ELEMENTS_EXCEEDED',
  ResponseStatus.OVER_QUERY_LIMIT: 'OVER_QUERY_LIMIT',
  ResponseStatus.REQUEST_DENIED: 'REQUEST_DENIED',
  ResponseStatus.UNKNOWN_ERROR: 'UNKNOWN_ERROR',
  ResponseStatus.ZERO_RESULTS: 'ZERO_RESULTS',
};
