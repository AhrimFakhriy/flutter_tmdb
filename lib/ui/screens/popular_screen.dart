import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/ui/screens/movie_screen.dart';
import 'package:tmdb_app/ui/view_models/popular_screen_view_model.dart';
import 'package:tmdb_app/ui/widgets/loading_widget.dart';
import 'package:tmdb_app/utils/enums.dart';
import 'package:tmdb_app/utils/services.dart';

class PopularScreen extends StatefulWidget {
  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final PopularScreenViewModel _viewModel = services.get<PopularScreenViewModel>();
  ScrollController _scrollController;
  ViewState _viewState;

  @override
  void initState() {
    super.initState();
    loadData();

    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();

    super.dispose();
  }

  Future<void> loadData({reload = false}) async {
    if(_viewState == ViewState.IsLoading) return;
    setState(() => _viewState = ViewState.IsLoading);

    try { 
      await _viewModel.loadMovies(reload: reload); 
      setState(() => _viewState = ViewState.HasData);

    } catch (error) { 
      setState(() => _viewState = ViewState.HasError); 
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    if(_viewState == ViewState.IsLoading)
      return const CenteredLoader();

    if(_viewState == ViewState.HasError)
      return const Center(child: const Text("Error"));

    return ChangeNotifierProvider<PopularScreenViewModel>.value(
      value: _viewModel,
      child: Consumer<PopularScreenViewModel>(
        builder: (context, provider, child) => RefreshIndicator(
        onRefresh: () => loadData(reload: true),
        child: GridView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: mediaQuery.orientation == Orientation.portrait ? 2 : 4,
            childAspectRatio: 2/3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: provider.movies.length,
          itemBuilder: (context, index) {
            var movie = provider.movies[index];

            return OpenContainer(
              closedColor: Colors.transparent,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
              ),
              transitionDuration: Duration(milliseconds: 350),
              openBuilder: (context, action) => MovieScreen(movie: movie),
              closedBuilder: (context, action) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
                      child: Hero(
                        tag: movie.poster,
                        child: CachedNetworkImage(
                          imageUrl: movie.posterUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(6)),
                      color: Colors.black87,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        Text("${movie.avgVote}"),
                        Spacer(),
                      ]
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}