import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  final String _overview;

  MovieOverview(this._overview);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: Colors.deepOrange,
          ),
          Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Overview",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(_overview, style: Theme.of(context).textTheme.subtitle1,),
          ),
        ],
      ),
    );
  }
}
