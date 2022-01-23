// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlacesResult _$PlacesResultFromJson(Map<String, dynamic> json) => PlacesResult()
  ..predictions = (json['predictions'] as List<dynamic>?)
          ?.map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList() ??
      []
  ..status = $enumDecodeNullable(_$ResponseStatusEnumMap, json['status']);

Map<String, dynamic> _$PlacesResultToJson(PlacesResult instance) =>
    <String, dynamic>{
      'predictions': instance.predictions,
      'status': _$ResponseStatusEnumMap[instance.status],
    };

const _$ResponseStatusEnumMap = {
  ResponseStatus.OK: 'OK',
  ResponseStatus.INVALID_REQUEST: 'INVALID_REQUEST',
  ResponseStatus.MAX_ELEMENTS_EXCEEDED: 'MAX_ELEMENTS_EXCEEDED',
  ResponseStatus.OVER_QUERY_LIMIT: 'OVER_QUERY_LIMIT',
  ResponseStatus.REQUEST_DENIED: 'REQUEST_DENIED',
  ResponseStatus.UNKNOWN_ERROR: 'UNKNOWN_ERROR',
  ResponseStatus.ZERO_RESULTS: 'ZERO_RESULTS',
};
