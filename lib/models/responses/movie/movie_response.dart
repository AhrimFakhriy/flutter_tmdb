import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../movie/movie.dart';
import '../base_response.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse extends BaseResponse with EquatableMixin {
  List<Movie> results;

  MovieResponse({
    int page,
    int totalPages,
    int totalResults,
    this.results = const [],
  }): super(
    page: page,
    totalPages: totalPages,
    totalResults: totalResults,
  );

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
    _$MovieResponseFromJson(json);

  @override
  List<Object> get props => [...super.props, results];

  @override
  bool get stringify => true;

}