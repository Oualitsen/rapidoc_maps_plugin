// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) {
  return Step()
    ..distance = json['distance'] == null
        ? null
        : TextValue.fromJson(json['distance'] as Map<String, dynamic>)
    ..duration = json['duration'] == null
        ? null
        : TextValue.fromJson(json['duration'] as Map<String, dynamic>)
    ..startLocation = json['start_location'] == null
        ? null
        : LatLng.fromJson(json['start_location'] as Map<String, dynamic>)
    ..endLocation = json['end_location'] == null
        ? null
        : LatLng.fromJson(json['end_location'] as Map<String, dynamic>)
    ..polyline = json['polyline'] == null
        ? null
        : Polyline.fromJson(json['polyline'] as Map<String, dynamic>)
    ..HtmlInstructions = json['html_instructions'] as String?
    ..travelMode = json['travel_mode'] as String?;
}

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'start_location': instance.startLocation,
      'end_location': instance.endLocation,
      'polyline': instance.polyline,
      'html_instructions': instance.HtmlInstructions,
      'travel_mode': instance.travelMode,
    };
