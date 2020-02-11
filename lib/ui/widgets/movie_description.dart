import 'package:flutter/material.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/model/movie_details_response.dart';
import 'package:intl/intl.dart';
import 'package:moviedb/util/utils.dart';

import '../injection.dart';

class MovieDescription extends StatefulWidget {
  final MovieDetailsResponse movie;
  final NumberFormat _formatter = Injector.provideCurrency();

  MovieDescription(this.movie);

  @override
  _MovieDescriptionState createState() => _MovieDescriptionState();
}

class _MovieDescriptionState extends State<MovieDescription> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
//        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(
            Utils.getMediumImageUrl(widget.movie.posterPath),
            fit: BoxFit.cover,
            width: 120,
            height: 200,
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Budget: ${ widget._formatter.format(widget.movie.budget)}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  Container(
                    child: Text(
                      "Release: ${widget.movie.releaseDate}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Runtime: ${widget.movie.runtime} min",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Rating: ${widget.movie.voteAverage}/10",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                  Container(
                    child: Text(
                      "Status: ${widget.movie.status}",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }


}
