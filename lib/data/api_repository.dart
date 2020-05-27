import 'package:tmdb_app/models/responses/base_response.dart';

import '../models/movie/movie.dart';
import '../models/responses/movie/movie_response.dart';

import 'api_provider.dart';

class ApiRepository {
  final ApiProvider provider = ApiProvider();

  Future<MovieResponse> getPopularMovies() =>
    provider.getPopularMovies();

  Future<Movie> getMovieById(int id) =>
    provider.getMovieById(id);

  Future<T> loadPage<T extends BaseResponse>(T response, int page) =>
    provider.loadPage(response, page);

}