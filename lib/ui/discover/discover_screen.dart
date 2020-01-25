import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/discover/disocver_bloc_provider.dart';

import 'dicover_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  DiscoverBloc discoverBloc;

//  @override
//  void initState() {
//    super.initState();
//    discoverBloc = DiscoverBlocProvider.of(context);
//    discoverBloc.fetchAllMovies();
//  }

  @override
  void didChangeDependencies() {
    discoverBloc = DiscoverBlocProvider.of(context);
    discoverBloc.fetchAllMovies();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    discoverBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: StreamBuilder(
        stream: discoverBloc.allMovies,
        builder: (context, AsyncSnapshot<MoviesResponse> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<MoviesResponse> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.results.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
            fit: BoxFit.cover,
          );
        });
  }
}
