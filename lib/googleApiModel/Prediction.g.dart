// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Prediction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Prediction _$PredictionFromJson(Map<String, dynamic> json) {
  return Prediction()
    ..description = json['description'] as String?
    ..id = json['id'] as String?
    ..matchedSubStrings = (json['matched_substrings'] as List<dynamic>?)
            ?.map((e) => MatchedSubstring.fromJson(e as Map<String, dynamic>))
            .toList() ??
        []
    ..placeId = json['place_id'] as String?
    ..reference = json['reference'] as String?
    ..structuredFormatting = json['structured_formatting'] == null
        ? null
        : StructuredFormatting.fromJson(json['structured_formatting'] as Map<String, dynamic>)
    ..terms = (json['terms'] as List<dynamic>?)
        ?.map((e) => Term.fromJson(e as Map<String, dynamic>))
        .toList()
    ..types = (json['types'] as List<dynamic>?)?.map((e) => e as String).toList();
}

Map<String, dynamic> _$PredictionToJson(Prediction instance) => <String, dynamic>{
      'description': instance.description,
      'id': instance.id,
      'matched_substrings': instance.matchedSubStrings,
      'place_id': instance.placeId,
      'reference': instance.reference,
      'structured_formatting': instance.structuredFormatting,
      'terms': instance.terms,
      'types': instance.types,
    };
