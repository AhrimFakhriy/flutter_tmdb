import 'package:dio/dio.dart';
import 'package:tmdb_app/models/responses/base_response.dart';
import '../utils/methods.dart';
import '../models/responses/movie/movie_response.dart';
import '../models/movie/movie.dart';
import '../utils/settings.dart';

class ApiProvider {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: API_BASE_URL,
      queryParameters: { "api_key": API_KEY },
    ),
  );

  Future<MovieResponse> getPopularMovies() async {
    try {

      var dio = Dio();

      final response = await _dio.get("/movie/popular");
      return MovieResponse.fromJson(response.data)..path = "/movie/popular";

    } catch (error, trace) {
      printError(error, trace);
      throw error;

    }
  }

  Future<T> loadPage<T extends BaseResponse>(T response, int page) async {
    assert(response.path != null);
    assert(page >= 1);

    try {
      final res = await _dio.get(response.path, queryParameters: {"page": page});

      if(response is MovieResponse) 
        return MovieResponse.fromJson(res.data) as T;

      throw Exception("Type is not implemented!");

    } catch (error, trace) {
      printError(error, trace);
      throw error;

    }
  }

  Future<Movie> getMovieById(int id) async {
    try {
      final response = await _dio.get("/movie/$id");
      print(response.data);
      return Movie.fromJson(response.data);

    } catch (error, trace) {
      printError(error, trace);
      throw error;

    }
  }

}