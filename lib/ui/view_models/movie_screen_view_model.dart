import 'dart:collection';

import '../../data/api_repository.dart';
import '../../models/movie/movie.dart';
import '../../utils/services.dart';
import 'base_view_model.dart';

class MovieScreenViewModel extends BaseViewModel {
  final ApiRepository _repository = services.get<ApiRepository>();
  final HashMap<int, Movie> _loadedMovies = HashMap();

  Movie get movie => _loadedMovies[currentId];
  int currentId;

  Future<void> loadMovie(int id) async {
    if(isLoading) return;

    currentId = id;

    if(_loadedMovies.containsKey(id))
      return;

    setLoading(true);

    try {
      _loadedMovies[id] = await _repository.getMovieById(id);
      notifyListeners();
      
    } catch (error) {
      throw error;

    } finally {
      setLoading(false);

    }
  }
}