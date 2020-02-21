import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/model/collection_type.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/mobiedetails/movie_details_screen.dart';
import 'package:moviedb/ui/movieslist/movies_list_screen.dart';
import 'package:moviedb/util/utils.dart';

class MoviesHorizontalList extends StatelessWidget {
  final String _title;
  final List<Movie> _movies;
  final CollectionType collectionType;

  MoviesHorizontalList(this._title, this._movies, this.collectionType);

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double cellHeight = orientation == Orientation.portrait ? height * 0.33 : height * 0.5;
    final double cellWidth = orientation == Orientation.portrait ? width * 0.28 : width * 0.17;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.8,
      ),
      height: cellHeight,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: <Widget>[
                _titleWidget(context, _title),
                Spacer(),
                _moreWidget(context),
              ],
            ),
          ),
          Expanded(
              child: _createList(
            context,
            cellHeight,
            cellWidth,
          )),
        ],
      ),
    );
  }

  ListView _createList(BuildContext context, double cellHeight, double cellWidth) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _movies.length,
        itemBuilder: (context, index) => _buildListItem(context, index, cellHeight, cellWidth));
  }

  Widget _buildListItem(BuildContext context, int index, double cellHeight, double cellWidth) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        final movie = _movies[index];
                        return MovieDetailsScreen(movie);
                      },
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: Utils.getMediumImageUrl(_movies[index].posterPath),
                    placeholder: (context, url) => Icon(
                      Icons.local_movies,
                      size: 48,
                      color: Colors.black87,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: cellWidth,
            child: Text(
              _movies[index].title,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleWidget(BuildContext context, String title) {
    return Text(title, style: Theme.of(context).textTheme.headline6);
  }

  Widget _moreWidget(BuildContext context) {
    return FlatButton(
      child: Text(
        "More",
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: Colors.deepOrange,
            ),
      ),
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MoviesListScreen(collectionType),
        ),
      ),
    );
  }

  _navigate(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoviesListScreen(collectionType),
      ),
    );
  }
}
