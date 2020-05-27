import 'dart:collection';

import '../../models/responses/movie/movie_response.dart';
import '../../data/api_repository.dart';
import '../../models/movie/movie.dart';
import '../../utils/services.dart';
import 'base_view_model.dart';

class PopularScreenViewModel extends BaseViewModel {
  final ApiRepository _repository = services.get<ApiRepository>();
  MovieResponse _movieResponse;
  bool _isLoaded = false;

  final List<Movie> _movies = [];
  List<Movie> get movies => _movies..sort((a, b) => b.avgVote.compareTo(a.avgVote));

  Future<bool> loadMovies({bool reload = false}) async {
    if(isLoading) return false;
    if(_isLoaded && !reload) return false;

    setLoading(true);

    try {
      _movieResponse = await _repository.getPopularMovies();

      if(reload)
        _movies.clear();

      _movies.addAll(_movieResponse.results);

      _isLoaded = true;
      notifyListeners();

      return true;

    } catch (error) {
      _isLoaded = false;

      throw error;

    } finally {
      setLoading(false);
    }
  }

  Future<void> loadPage(int page) async {
    if(isLoading) return;
    if(_movieResponse.page >= page) return;

    if(!_isLoaded)
      await loadMovies();

    setLoading(true);

    try {
      _movieResponse = await _repository.loadPage(_movieResponse, page);
      _movies.addAll(_movieResponse.results);

      _isLoaded = true;
      notifyListeners();

    } catch (error) {
      _isLoaded = false;
      throw error;

    } finally {
      setLoading(false);

    }
  }
}