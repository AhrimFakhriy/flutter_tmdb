// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['id'] as int,
    title: json['title'] as String,
    budget: json['budget'] as int,
    backdrop: json['backdrop_path'] as String,
    poster: json['poster_path'] as String,
    isAdult: json['adult'] as bool,
    avgVote: (json['vote_average'] as num)?.toDouble(),
    language: json['original_language'] as String,
    overview: json['overview'] as String,
    productions: (json['production_companies'] as List)
        ?.map((e) =>
            e == null ? null : Production.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    date: json['release_date'] as String,
    revenue: json['revenue'] as int,
    duration: json['runtime'] as int,
    status: json['status'] as String,
    tagline: json['tagline'] as String,
    popularity: (json['popularity'] as num)?.toDouble(),
    genres: (json['genres'] as List)
        ?.map(
            (e) => e == null ? null : Genre.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'budget': instance.budget,
      'backdrop_path': instance.backdrop,
      'poster_path': instance.poster,
      'adult': instance.isAdult,
      'original_language': instance.language,
      'vote_average': instance.avgVote,
      'overview': instance.overview,
      'release_date': instance.date,
      'revenue': instance.revenue,
      'production_companies': instance.productions,
      'runtime': instance.duration,
      'status': instance.status,
      'tagline': instance.tagline,
      'popularity': instance.popularity,
      'genres': instance.genres,
    };
