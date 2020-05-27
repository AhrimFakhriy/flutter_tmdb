import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/utils/settings.dart';

part 'production.g.dart';

@JsonSerializable()
class Production {
  final int id;

  @JsonKey(name: "logo_path")
  final String logo;

  final String name;

  @JsonKey(name: "origin_country")
  final String countryOrigin;

  Production({
    this.id,
    this.logo,
    this.name,
    this.countryOrigin
  });

  factory Production.fromJson(Map<String, dynamic> json) =>
    _$ProductionFromJson(json);

  String get logoUrl => logo.isEmpty ? "" : "$IMAGE_API_URL$logo";
}