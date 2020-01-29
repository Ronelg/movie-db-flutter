import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/movieslist/bloc/movies_list_event.dart';
import 'package:moviedb/ui/movieslist/bloc/movies_list_state.dart';

import 'bloc/movies_list_bloc.dart';

class MoviesListScreen extends StatefulWidget {
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
    _bloc.add(MoviesListFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
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
      color: Colors.black87,
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
      _bloc.add(MoviesListFetch());
//      });
    }
  }
}
