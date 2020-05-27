import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tmdb_app/models/genre/genre.dart';
import 'package:tmdb_app/models/production/production.dart';
import 'package:tmdb_app/utils/settings.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie with EquatableMixin {
  final int id;

  final String title;

  @JsonKey(nullable: true)
  final int budget;

  @JsonKey(name: "backdrop_path")
  final String backdrop;

  @JsonKey(name: "poster_path")
  final String poster;

  @JsonKey(name: "adult")
  final bool isAdult;

  @JsonKey(name: "original_language")
  final String language;

  @JsonKey(name: "vote_average")
  final double avgVote;

  final String overview;

  @JsonKey(name: "release_date")
  final String date;

  @JsonKey(nullable: true)
  final int revenue;

  @JsonKey(name: "production_companies")
  final List<Production> productions;

  @JsonKey(name: "runtime", nullable: true)
  final int duration;

  @JsonKey(nullable: true)
  final String status;

  @JsonKey(nullable: true)
  final String tagline;

  final double popularity;

  @JsonKey(nullable: true)
  final List<Genre> genres;

  Movie({
    this.id,
    this.title,
    this.budget,
    this.backdrop,
    this.poster,
    this.isAdult,
    this.avgVote,
    this.language,
    this.overview,
    this.productions,
    this.date,
    this.revenue,
    this.duration,
    this.status,
    this.tagline,
    this.popularity,
    this.genres
  });

  factory Movie.fromJson(Map<String, dynamic> json) =>
    _$MovieFromJson(json);

  @override
  List<Object> get props => [id, title, isAdult, poster, backdrop, language, overview, date, popularity, avgVote];

  @override
  bool get stringify => true;

  String get posterUrl => poster == null ? "" : "$IMAGE_API_URL$poster";
  String get backdropUrl => backdrop == null ? "" : "$IMAGE_API_URL$backdrop";

}