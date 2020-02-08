import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/ui/widgets/movie_description.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  MovieDetailsScreen(this.movie);

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final Logger logger = Logger();
  _SliverAppBarDelegate2 w;

  @override
  void initState() {
    logger.i(widget.movie.id);

    w = _SliverAppBarDelegate2(
      maxHeight: 250,
      minHeight: kToolbarHeight + 10,
      movie: widget.movie,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            delegate: w,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildList(context, index),
            ),
          )
        ],
      ),
    );
  }

  _buildList(BuildContext context,int index) {
    if(index == 0) {
      return MovieDescription(widget.movie);
    } else {
      return ListTile(
        title: Text("Index: $index", style: Theme.of(context).accentTextTheme.title),
      );
    }
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final Movie movie;

  MySliverAppBar({@required this.expandedHeight, @required this.movie});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        children: [
          Container(
            child: FadeInImage.assetNetwork(
//          image: "https://image.tmdb.org/t/p/w300${movie.posterPath}",
              image:
                  "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
//            placeholder: "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              fadeInDuration: Duration(microseconds: 700),

//          "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Opacity(
//              opacity: shrinkOffset / expandedHeight,
              child: Text(
                "MySliverAppBar",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 23,
                ),
              ),
            ),
          ),
          Positioned(
            top: expandedHeight / 2 - shrinkOffset,
            left: 0, //MediaQuery.of(context).size.width / 4,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Card(
                elevation: 0,
                child: SizedBox(
                  height: expandedHeight,
                  width: MediaQuery.of(context).size.width / 2,
                  child: FlutterLogo(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
//    return maxHeight != oldDelegate.maxHeight ||
//        minHeight != oldDelegate.minHeight ||
//        child != oldDelegate.child;
  }
}

class _SliverAppBarDelegate2 extends SliverPersistentHeaderDelegate {
  final logger = Logger();

  _SliverAppBarDelegate2({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.movie,
  });

  final double minHeight;
  final double maxHeight;

//  final Widget child;
  final Movie movie;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//    logger.i("oppacity: ${1 - (shrinkOffset / maxHeight) }");

    num offset = 1 - (shrinkOffset / (maxHeight * 0.36));
    num opacity = offset > 0 ? offset : 0.01;

    logger.i(
        "shrinkOffset: $shrinkOffset maxHeight:${maxHeight} opacity: ${opacity}");

    return SizedBox.expand(
      child: Stack(
        overflow: Overflow.visible,
        fit: StackFit.expand,
        children: <Widget>[
          Image.network(
            "https://image.tmdb.org/t/p/w300${movie.backdropPath}",
            fit: BoxFit.cover,
          ),

          AppBar(
            backgroundColor: Colors.transparent,
            title: Opacity(
              opacity: (shrinkOffset / maxHeight),
              child: Text(movie.title),
            ),
            flexibleSpace: Container(
              height: maxHeight,
            ),
          ),

          // Appbar title
          Positioned(
            top: maxHeight - 100 - kFloatingActionButtonMargin - shrinkOffset,
            left: kFloatingActionButtonMargin + shrinkOffset * 0.6,
            child: Container(
              child: Text(
                movie.title,
                style: Theme.of(context).textTheme.title.copyWith(color: Colors.white.withOpacity(opacity)),
              ),
            ),
          ),

//          Positioned(
//            top: maxHeight / 2 - shrinkOffset,
//            left: 0, //MediaQuery.of(context).size.width / 4,
//            child: Opacity(
//              opacity: (1 - shrinkOffset / maxHeight),
//              child: Card(
//                elevation: 0,
//                child: SizedBox(
//                  height: maxHeight,
//                  width: MediaQuery.of(context).size.width / 2,
//                  child: FlutterLogo(),
//                ),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}
