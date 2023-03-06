// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leg _$LegFromJson(Map<String, dynamic> json) => Leg()
  ..distance = json['distance'] == null
      ? null
      : TextValue.fromJson(json['distance'] as Map<String, dynamic>)
  ..duration = json['duration'] == null
      ? null
      : TextValue.fromJson(json['duration'] as Map<String, dynamic>)
  ..startAddress = json['start_address'] as String?
  ..endAddress = json['end_address'] as String?
  ..startLocation = json['start_location'] == null
      ? null
      : Coords.fromJson(json['start_location'] as Map<String, dynamic>)
  ..endLocation = json['end_location'] == null
      ? null
      : Coords.fromJson(json['end_location'] as Map<String, dynamic>)
  ..steps = (json['steps'] as List<dynamic>?)
      ?.map((e) => Step.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$LegToJson(Leg instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'start_address': instance.startAddress,
      'end_address': instance.endAddress,
      'start_location': instance.startLocation,
      'end_location': instance.endLocation,
      'steps': instance.steps,
    };
