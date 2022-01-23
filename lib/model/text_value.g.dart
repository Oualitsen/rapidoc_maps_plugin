// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextValue _$TextValueFromJson(Map<String, dynamic> json) => TextValue()
  ..text = json['text'] as String?
  ..value = json['value'] as int?
  ..distance = json['distance'] as bool?;

Map<String, dynamic> _$TextValueToJson(TextValue instance) => <String, dynamic>{
      'text': instance.text,
      'value': instance.value,
      'distance': instance.distance,
    };
