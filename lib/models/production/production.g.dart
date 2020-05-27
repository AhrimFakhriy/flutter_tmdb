// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'production.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Production _$ProductionFromJson(Map<String, dynamic> json) {
  return Production(
    id: json['id'] as int,
    logo: json['logo_path'] as String,
    name: json['name'] as String,
    countryOrigin: json['origin_country'] as String,
  );
}

Map<String, dynamic> _$ProductionToJson(Production instance) =>
    <String, dynamic>{
      'id': instance.id,
      'logo_path': instance.logo,
      'name': instance.name,
      'origin_country': instance.countryOrigin,
    };
