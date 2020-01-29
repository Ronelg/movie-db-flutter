import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/home/bloc/home_bloc.dart';
import 'package:moviedb/ui/widgets/movies_horizontal_list.dart';
import 'package:moviedb/ui/widgets/movies_poster_horizontal_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//  HomeBloc _bloc;

  @override
  void initState() {
    super.initState();
    homeBloc.load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//    _bloc.load();
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
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
      backgroundColor: Colors.blueGrey[900],
    );
  }
}

Widget _buildPopularList(BuildContext context, String title) {
  return Container(
    child: StreamBuilder(
      stream: homeBloc.popularMovies,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return MoviesHorizontalList(title, snapshot.data);
        } else {
          return Container();
        }
      },
    ),
  );
}

Widget _buildTopRatedList(BuildContext context, String title) {
  return Container(
    child: StreamBuilder(
      stream: homeBloc.topRatedMovies,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return MoviesHorizontalList(title, snapshot.data);
        } else {
          return Container();
        }
      },
    ),
  );
}

Widget _buildUpcomingList(BuildContext context, String title) {
  return Container(
    child: StreamBuilder(
      stream: homeBloc.upcomingMovies,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return MoviesHorizontalList(title, snapshot.data);
        } else {
          return Container();
        }
      },
    ),
  );
}

Widget _buildNowPlayingList(BuildContext context, String title) {
  return Container(
    child: StreamBuilder(
      stream: homeBloc.nowPlayingMovies,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          return MoviesPosterHorizontalList(title, snapshot.data);
        } else {
          return Container();
        }
      },
    ),
  );
}


