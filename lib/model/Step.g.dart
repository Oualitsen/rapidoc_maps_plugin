// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) => Step()
  ..distance = json['distance'] == null
      ? null
      : TextValue.fromJson(json['distance'] as Map<String, dynamic>)
  ..duration = json['duration'] == null
      ? null
      : TextValue.fromJson(json['duration'] as Map<String, dynamic>)
  ..startLocation = json['start_location'] == null
      ? null
      : Coords.fromJson(json['start_location'] as Map<String, dynamic>)
  ..endLocation = json['end_location'] == null
      ? null
      : Coords.fromJson(json['end_location'] as Map<String, dynamic>)
  ..polyline = json['polyline'] == null
      ? null
      : Polyline.fromJson(json['polyline'] as Map<String, dynamic>)
  ..htmlInstructions = json['html_instructions'] as String?
  ..travelMode = json['travel_mode'] as String?;

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'start_location': instance.startLocation,
      'end_location': instance.endLocation,
      'polyline': instance.polyline,
      'html_instructions': instance.htmlInstructions,
      'travel_mode': instance.travelMode,
    };
