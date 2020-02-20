import 'package:flutter/material.dart';
import 'package:moviedb/model/movie_videos_response.dart';
import 'package:moviedb/ui/injection.dart';
import 'package:moviedb/util/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieRelatedVideos extends StatelessWidget {
  final List<MovieVideo> _videos;
  final logger = Injector.provideLogger();

  MovieRelatedVideos(this._videos);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(color: Colors.green,),
          _buildTitle(context),
          _buildVideosList(context),
        ],
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
      alignment: Alignment.topLeft,
      child: Text(
        "Videos",
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  _buildVideosList(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *0.3,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: _videos.length ?? 0,
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildVideoItem(context, index),
      ),
    );
  }

  _buildVideoItem(BuildContext context, int index) {
    return Container(
//      padding: EdgeInsets.only(right: 8.0),
      child: Card(
        child: GestureDetector(
          child: Image.network(
            Utils.youtubeVideoThumbnail(_videos[index].key),
            fit: BoxFit.cover,
          ),
          onTap: () => __launchURL(_videos[index].key),
        ),
      )
    );
  }

  __launchURL(String videoId) async {
    String url = 'https://www.youtube.com/watch?v=$videoId';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
