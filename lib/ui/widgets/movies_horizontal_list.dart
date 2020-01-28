import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moviedb/model/movie.dart';

class MoviesHorizontalList extends StatelessWidget {
  final String _title;
  final List<Movie> _movies;

  MoviesHorizontalList(this._title, this._movies);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = MediaQuery.of(context).size.height;
    final double cellHeight = orientation == Orientation.portrait ? height * 0.33 : height * 0.5;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.8),
      height: cellHeight,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                _titleWidget(context, _title),
                Spacer(),
                _moreWidget(),
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
}

ListView _createList(BuildContext context, List<Movie> movies) {
  final Orientation orientation = MediaQuery.of(context).orientation;
  final double width = MediaQuery.of(context).size.width;
  final double cellWidth = orientation == Orientation.portrait ? width * 0.28 : width * 0.17;

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
                    child: Image.network(
                      'https://image.tmdb.org/t/p/w185${movies[index].posterPath}',
                      fit: BoxFit.cover,
                      width: cellWidth,
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
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.white,
    ),
  );
}

Widget _moreWidget() {
  return Text(
    "More",
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.green,
    ),
  );
}
