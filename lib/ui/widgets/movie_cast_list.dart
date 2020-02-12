import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/model/movie_credits_response.dart';
import 'package:moviedb/util/utils.dart';

class MovieCast extends StatelessWidget {
   List<Cast> _casts;

  MovieCast(List<Cast> casts){
    casts.removeWhere((element) => element.profilePath == null);
    _casts = casts;
  }

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
          _buildCastList(context),
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

  _buildCastList(BuildContext context) {
    final listHeight = MediaQuery.of(context).size.height * 0.3;
    final listWidth = MediaQuery.of(context).size.width;

    return Container(
      height: listHeight,
      width: listWidth,
      child: ListView.builder(
        itemCount: _casts.length ?? 0,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildCastItem(context, index),
      ),
    );
  }

  _buildCastItem(BuildContext context, int index) {
    final double cellWidth = 120;

    return Container(
      padding: EdgeInsets.only(right: 8.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: cellWidth,
              child: Image.network(
                Utils.getMediumImageUrl(_casts[index].profilePath),
                fit: BoxFit.cover,
              ),
            ),
            flex: 3,
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: cellWidth,
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                _casts[index].name,
                overflow: TextOverflow.clip,
                maxLines: 3,
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
