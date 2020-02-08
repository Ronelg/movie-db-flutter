import 'package:flutter/material.dart';
import 'package:moviedb/model/movie.dart';

class MovieDescription extends StatefulWidget {
  final Movie movie;

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
            "https://image.tmdb.org/t/p/w300${widget.movie.posterPath}",
            fit: BoxFit.cover,
            width: 120,
            height: 200,
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Director: ${widget.movie.title}",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context).accentTextTheme.body1,
                ),
                Container(
                  child: Text(
                    "Release: ${widget.movie.releaseDate}",
                    style: Theme.of(context).accentTextTheme.body1,
                  ),
                ),
                Container(
                  child: Text(
                    "Release: ${widget.movie.releaseDate}",
                    style: Theme.of(context).accentTextTheme.body1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


}
