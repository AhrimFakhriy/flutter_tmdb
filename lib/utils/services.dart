import 'package:get_it/get_it.dart';
import '../ui/view_models/movie_screen_view_model.dart';
import '../data/api_repository.dart';
import '../ui/view_models/popular_screen_view_model.dart';

final services = GetIt.instance;

void registerServices() {
  services.registerLazySingleton<ApiRepository>(() => ApiRepository());
  services.registerLazySingleton<MovieScreenViewModel>(() => MovieScreenViewModel());
  services.registerLazySingleton<PopularScreenViewModel>(() => PopularScreenViewModel());
}