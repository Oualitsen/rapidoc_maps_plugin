// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'structured_formatting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StructuredFormatting _$StructuredFormattingFromJson(
        Map<String, dynamic> json) =>
    StructuredFormatting(
      json['main_text'] as String?,
      json['secondary_text'] as String?,
    )..mainTextMatchedSubstrings =
        (json['main_text_matched_substrings'] as List<dynamic>?)
            ?.map((e) => Term.fromJson(e as Map<String, dynamic>))
            .toList();

Map<String, dynamic> _$StructuredFormattingToJson(
        StructuredFormatting instance) =>
    <String, dynamic>{
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
      'main_text_matched_substrings': instance.mainTextMatchedSubstrings,
    };
