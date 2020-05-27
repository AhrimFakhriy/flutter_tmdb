import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/models/movie/movie.dart';
import 'package:tmdb_app/ui/view_models/movie_screen_view_model.dart';
import 'package:tmdb_app/ui/widgets/loading_widget.dart';
import 'package:tmdb_app/utils/enums.dart';
import 'package:tmdb_app/utils/services.dart';

class MovieScreen extends StatefulWidget {
  static const route = "/movie-screen";
  final Movie movie;

  MovieScreen({
    @required this.movie
  });

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final MovieScreenViewModel _viewModel = services.get<MovieScreenViewModel>();
  ViewState _viewState;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    if(_viewState == ViewState.IsLoading) return;
    setState(() => _viewState = ViewState.IsLoading);

    try {
      await _viewModel.loadMovie(widget.movie.id);
      setState(() => _viewState = ViewState.HasData);

    } catch (error) {
      setState(() => _viewState = ViewState.HasError);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    if(_viewState == ViewState.IsLoading)
      return Scaffold(
        body: CenteredLoader(),
      );

    return Scaffold(
      body: ChangeNotifierProvider<MovieScreenViewModel>.value(
        value: _viewModel,
        child: Consumer<MovieScreenViewModel>(
          builder: (context, provider, child) => CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: mediaQuery.size.width/2,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: mediaQuery.size.width - 160),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Text(
                        provider.movie.title,
                        style: Theme.of(context).textTheme.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: (constraints.maxHeight / Theme.of(context).textTheme.title.fontSize).floor() < 2 
                          ? (constraints.maxHeight / Theme.of(context).textTheme.title.fontSize).floor()
                          : 2
                      ),
                    ),
                  ),
                  background: CachedNetworkImage(
                    imageUrl: provider.movie.backdropUrl ?? provider.movie.posterUrl ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 7,
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Hero(
                                  tag: provider.movie.poster,
                                  child: CachedNetworkImage(
                                    imageUrl: provider.movie.posterUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 8),

                          Expanded(
                            flex: 8,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(height: 6),
                                  Text(
                                    provider.movie.title,
                                    style: Theme.of(context).textTheme.body2,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    "${provider.movie.date} - ${provider.movie.status}",
                                    style: Theme.of(context).textTheme.caption
                                  ),
                                  Divider(),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 40
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider.movie.genres.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: index != 0 ? const EdgeInsets.only(left: 2) : EdgeInsets.zero,
                                        child: Chip(
                                          label: Text(
                                            provider.movie.genres[index].name,
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6),

                                  if(provider.movie.avgVote != null) ...[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "User Score:",
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Text("${(provider.movie.avgVote * 10).toStringAsFixed(1)} %"),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                  ],

                                  if(provider.movie.budget > 0) ...[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Budget:",
                                          style: TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        Spacer(),
                                        Text("\$${provider.movie.budget}"),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                  ],

                                  if(provider.movie.revenue > 0) ...[
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          "Revenue:",
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Text("\$${provider.movie.revenue}"),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                  ],

                                  if(provider.movie.duration > 0) ...[
                                    Row(
                                      children: <Widget>[
                                        const Text(
                                          "Runtime:",
                                          style: const TextStyle(fontWeight: FontWeight.w500),
                                        ),
                                        const Spacer(),
                                        Text("${provider.movie.duration} minutes")
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                  ],

                                  SizedBox(height: 4),

                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 40
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider.movie.productions.length,
                                      itemBuilder: (context, index) => Padding(
                                        padding: index != 0 ? const EdgeInsets.only(left: 2) : EdgeInsets.zero,
                                        child: Chip(
                                          label: Text(
                                            provider.movie.productions[index].name,
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                  if(provider.movie.tagline.isNotEmpty)
                    Text(
                      provider.movie.tagline,
                      style: Theme.of(context).textTheme.subtitle.copyWith(
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    Divider(),
                    Text(
                      provider.movie.overview,
                      textAlign: TextAlign.justify,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}