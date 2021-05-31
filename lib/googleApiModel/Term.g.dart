// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Term.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Term _$TermFromJson(Map<String, dynamic> json) {
  return Term(
    value: json['value'] as String?,
    offset: json['offset'] as int,
  );
}

Map<String, dynamic> _$TermToJson(Term instance) => <String, dynamic>{
      'offset': instance.offset,
      'value': instance.value,
    };
