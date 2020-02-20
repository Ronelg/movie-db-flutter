import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/model/collection_type.dart';
import 'package:moviedb/ui/home/bloc/home_event.dart';
import 'package:moviedb/ui/home/bloc/home_state.dart';
import 'package:moviedb/ui/widgets/movies_horizontal_list.dart';
import 'package:moviedb/ui/widgets/movies_poster_horizontal_list.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<HomeBloc>(context);

    _bloc..add(HomeFetchNowPlaying());
    _bloc..add(HomeFetchTopRated());
    _bloc..add(HomeFetchPopularMovies());
    _bloc..add(HomeFetchUpcoming());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TMDB"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                children: [
                  _buildNowPlayingList(context, "Movies Now Playing"),
                  _buildPopularList(context, "Popular Movies"),
                  _buildTopRatedList(context, "Movies Top Rated"),
                  _buildUpcomingList(context, "Movies Upcoming"),
                ],
              ),
            ),
          );
        },
      ),
//      backgroundColor: Colors.blueGrey[900],
    );
  }
}

Widget _buildPopularList(BuildContext context, String title) {
  return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
    if (state is HomeLoaded) {
      if (state.popularMovies != null) {
        return MoviesHorizontalList(title, state.popularMovies, CollectionType.PopularMovies);
      }
    }
    return Container();
  });
}

Widget _buildTopRatedList(BuildContext context, String title) {
  return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
    if (state is HomeLoaded) {
      if (state.topRatedMovies != null) {
        return MoviesHorizontalList(title, state.topRatedMovies, CollectionType.TopRatedMovies);
      }
    }
    return Container();
  });
}

Widget _buildUpcomingList(BuildContext context, String title) {
  return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
    if (state is HomeLoaded) {
      if (state.upcomingMovies != null) {
        return MoviesHorizontalList(title, state.upcomingMovies, CollectionType.UpcomingMovies);
      }
    }
    return Container();
  });
}

Widget _buildNowPlayingList(BuildContext context, String title) {
  return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
    if (state is HomeLoaded) {
      if (state.nowPlaying != null) {
        return MoviesPosterHorizontalList(title, state.nowPlaying, CollectionType.NowPlayingMovies);
      }
    }
    return Container();
  });
}
