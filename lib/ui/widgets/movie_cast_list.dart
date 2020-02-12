import 'package:flutter/material.dart';
import 'package:moviedb/model/movie_credits_response.dart';
import 'package:moviedb/util/utils.dart';

class MovieCast extends StatelessWidget {
  final List<Cast> _casts;

  MovieCast(this._casts);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: Colors.green,
          ),
          _buildTitle(context),
          buildCastList(context),
//          _buildVideosList(context),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      alignment: Alignment.topLeft,
      child: Text(
        "Casts",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  buildCastList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: _casts.length ?? 0,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildVideoItem(context, index),
      ),
    );
  }

  _buildVideoItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.only(right: 8.0),
      child: Image.network(
        Utils.getMediumImageUrl(_casts[index].profilePath),
        fit: BoxFit.cover,
      ),
    );
  }
}
