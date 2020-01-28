import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/discover/bloc/discover_event.dart';
import 'package:moviedb/ui/discover/bloc/discover_state.dart';

import 'bloc/dicover_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final _scrollController = ScrollController();
  DiscoverBloc _discoverBloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _discoverBloc = BlocProvider.of<DiscoverBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoaded) {
            return _buildList(state.movies);
          } else if (state is DiscoverError) {
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
          childAspectRatio: 1/ 1.6,
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
      _discoverBloc.add(DiscoverFetch());
//      });
    }
  }
}
