import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/model/collection_type.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/movieslist/bloc/movies_list_event.dart';
import 'package:moviedb/ui/movieslist/bloc/movies_list_state.dart';

import 'bloc/movies_list_bloc.dart';

class MoviesListScreen extends StatefulWidget {
  final CollectionType collectionType;

  MoviesListScreen(this.collectionType);

  @override
  _MoviesListScreenState createState() => _MoviesListScreenState();
}

class _MoviesListScreenState extends State<MoviesListScreen> {
  final _scrollController = ScrollController();
  MoviesListBloc _bloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _bloc = BlocProvider.of<MoviesListBloc>(context);

    _bloc.add(ClearState());
    _bloc.add(MoviesListFetch(widget.collectionType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      backgroundColor: Colors.black87,
      body: BlocBuilder<MoviesListBloc, MoviesListState>(
        builder: (context, state) {
          if (state is MoviesListLoaded) {
            return _buildList(state.movies);
          } else if (state is MoviesListError) {
            return Center(
              child: Text("Error"),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildList(List<Movie> snapshot) {
    return Container(
      child: GridView.builder(
        itemCount: snapshot.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1 / 1.6,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot[index].posterPath}',
            fit: BoxFit.cover,
          );
        },
        controller: _scrollController,
      ),
    );
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final outOfRange = _scrollController.position.outOfRange;

    if (offset >= maxScrollExtent && !outOfRange) {
//      setState(() {
      //reach the bottom
      _bloc.add(MoviesListFetch(widget.collectionType));
//      });
    }
  }

  Widget _title() {
    if (widget.collectionType == CollectionType.NowPlayingMovies) {
      return Text("Movies Now Playing");
    } else if (widget.collectionType == CollectionType.PopularMovies) {
      return Text("Popoular Movies");
    } else if (widget.collectionType == CollectionType.TopRatedMovies) {
      return Text("Top Rated Movies");
    } else if (widget.collectionType == CollectionType.UpcomingMovies) {
      return Text("Upcoming Movies");
    } else {
      return Text("");
    }
  }
}
