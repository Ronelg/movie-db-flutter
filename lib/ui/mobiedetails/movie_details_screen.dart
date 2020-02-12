import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/mobiedetails/bloc/movie_details_bloc.dart';
import 'package:moviedb/ui/mobiedetails/bloc/movie_details_event.dart';
import 'package:moviedb/ui/mobiedetails/bloc/movie_details_state.dart';
import 'package:moviedb/ui/widgets/movie_cast_list.dart';
import 'package:moviedb/ui/widgets/movie_description.dart';
import 'package:moviedb/ui/widgets/movie_overview_widget.dart';
import 'package:moviedb/ui/widgets/movie_related_videos.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailsScreen(this.movie);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsBloc _bloc;
  final Logger logger = Logger();
  _SliverAppBarDelegate2 w;

  @override
  void initState() {
    _bloc = BlocProvider.of<MovieDetailsBloc>(context);
    logger.i(widget.movie.id);

    w = _SliverAppBarDelegate2(
      maxHeight: 250,
      minHeight: kToolbarHeight + 10,
      movie: widget.movie,
    );

    _bloc.add(MovieDetailMovieEvent(widget.movie));
    _bloc.add(MovieDetailFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: w,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildList(context, index),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
//              height: 400,
              child: _buildVideos(context),
            ),
          ), SliverToBoxAdapter(
            child: Container(
//              height: 400,
              child: _buildMocieCast(context),
            ),
          ),
        ],
      ),
    );
  }

  _buildList(BuildContext context, int index) {
    if (index == 0) {
      return _buildMovieDetails(context);
    } else if (index == 1) {
      return _buildOverview(context);
    }
//    else if (index == 2) {
//      return _buildVideos(context);
//    }
  }
}

class _SliverAppBarDelegate2 extends SliverPersistentHeaderDelegate {
  final logger = Logger();

  _SliverAppBarDelegate2({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.movie,
  });

  final double minHeight;
  final double maxHeight;

//  final Widget child;
  final Movie movie;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//    logger.i("oppacity: ${1 - (shrinkOffset / maxHeight) }");

    num offset = 1 - (shrinkOffset / (maxHeight * 0.36));
    num opacity = offset > 0 ? offset : 0.01;

    logger.i("shrinkOffset: $shrinkOffset maxHeight:${maxHeight} opacity: ${opacity}");

    return SizedBox.expand(
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            "https://image.tmdb.org/t/p/w300${movie.backdropPath}",
            fit: BoxFit.cover,
          ),

          AppBar(
            backgroundColor: Colors.transparent,
            title: Opacity(
              opacity: (shrinkOffset / maxHeight),
              child: Text(movie.title),
            ),
            flexibleSpace: Container(
              height: maxHeight,
            ),
          ),

          // Appbar title
          Positioned(
            top: maxHeight - 100 - kFloatingActionButtonMargin - shrinkOffset,
            left: kFloatingActionButtonMargin + shrinkOffset * 0.6,
            child: Container(
              child: Text(
                movie.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white.withOpacity(opacity)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate2 oldDelegate) {
    return true;
  }
}

Widget _buildMovieDetails(BuildContext context) {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(builder: (context, state) {
    if (state is MovieDetailLoaded) {
      if (state.details != null) {
        return MovieDescription(state.details);
      }
    }
    return Container();
  });
}

Widget _buildOverview(BuildContext context) {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(builder: (context, state) {
    if (state is MovieDetailLoaded) {
      if (state.details != null) {
        return MovieOverview(state.details.overview);
      }
    }
    return Container();
  });
}

Widget _buildVideos(BuildContext context) {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(builder: (context, state) {
    if (state is MovieDetailLoaded) {
      if (state.videos != null) {
        return Container(
          child: MovieRelatedVideos(state.videos.results),
        );
      } else {
        return Container();
      }
    }

    return Container();
  });
}

Widget _buildMocieCast(BuildContext context) {
  return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(builder: (context, state) {
    if (state is MovieDetailLoaded) {
      if (state.videos != null) {
        return Container(
          child: MovieCast(state.credits.cast),
        );
      } else {
        return Container();
      }
    }

    return Container();
  });
}
