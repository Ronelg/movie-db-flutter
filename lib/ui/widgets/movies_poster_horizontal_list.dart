import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviedb/model/collection_type.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/mobiedetails/movie_details_screen.dart';
import 'package:moviedb/ui/movieslist/movies_list_screen.dart';
import 'package:moviedb/util/utils.dart';

class MoviesPosterHorizontalList extends StatelessWidget {
  final String _title;
  final List<Movie> _movies;
  final CollectionType collectionType;

  MoviesPosterHorizontalList(this._title, this._movies, this.collectionType);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = MediaQuery.of(context).size.height;
    final double cellHeight = orientation == Orientation.portrait ? height * 0.35 : height * 0.55;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: cellHeight,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                _titleWidget(context, _title),
                Spacer(),
                _moreWidget(context),
              ],
            ),
          ),
          Expanded(
            child: _createList(context, _movies),
          ),
        ],
      ),
    );
  }

  ListView _createList(BuildContext context, List<Movie> movies) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double width = MediaQuery.of(context).size.width;
    final double cellWidth = orientation == Orientation.portrait ? width * 0.85 : width * 0.45;

    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              children: <Widget>[
                Container(
//              width: cellWidth,
                  child: Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              final movie = movies[index];
                              return MovieDetailsScreen(movie);
                            },
                          ),
                        ),
                        child: Image.network(
                          Utils.getLargeImageUrl(movies[index].posterPath),
                          fit: BoxFit.cover,
                          width: cellWidth,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: cellWidth,
                  child: Text(
                    movies[index].title,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _titleWidget(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget _moreWidget(BuildContext context) {
    return FlatButton(
      child: Text(
        "More",
        style: Theme.of(context).textTheme.headline6.copyWith(color: Colors.green),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoviesListScreen(collectionType),
        ),
      ),
    );
  }
}
