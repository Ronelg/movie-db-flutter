import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/discover/discover_state.dart';

import 'dicover_bloc.dart';


class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  DiscoverBloc discoverBloc;

  @override
  Widget build(BuildContext context) {
    discoverBloc = BlocProvider.of<DiscoverBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoaded) {
            return buildList(state.movies);
          } else if (state is DiscoverError) {
            return Text("Error");
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(List<Movie> snapshot) {
    return GridView.builder(
        itemCount: snapshot.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot[index].posterPath}',
            fit: BoxFit.cover,
          );
        });
  }
}
