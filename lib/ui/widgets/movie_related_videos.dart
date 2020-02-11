import 'package:flutter/material.dart';
import 'package:moviedb/model/movie_videos_response.dart';
import 'package:moviedb/ui/injection.dart';
import 'package:moviedb/util/utils.dart';

class MovieRelatedVideos extends StatelessWidget {
  final List<MovieVideo> _videos;
  final logger = Injector.provideLogger();

  MovieRelatedVideos(this._videos);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      child: _buildVideosList(context),
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
    );
  }

  _buildTitle(BuildContext context) {
    return Text(
      "Videos",
      style: Theme.of(context).textTheme.headline6,
    );
  }

  _buildVideosList(BuildContext context) {
    return ListView.builder(
      itemCount: _videos.length ?? 0,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => _buildVideoItem(context, index),
    );
  }

  _buildVideoItem(BuildContext context, int index) {
    return Container(
      width: 220,
      height: 120,
      padding: EdgeInsets.only(right: 8.0),
      child: Image.network(
        Utils.youtubeVideoThumbnail(_videos[index].key),
        fit: BoxFit.cover,
      ),
    );
  }
}
