import 'package:logger/logger.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/injection.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final _repository = Injector.provideMovieRepository();
  final _popularMoviesSubject = PublishSubject<List<Movie>>();
  final _topRatedMoviesSubject = PublishSubject<List<Movie>>();
  final _nowPlayingMoviesSubject = PublishSubject<List<Movie>>();
  final _upcomingMoviesSubject = PublishSubject<List<Movie>>();
  final logger = Logger();

  Stream<List<Movie>> get popularMovies => _popularMoviesSubject.stream;
  Stream<List<Movie>> get topRatedMovies => _topRatedMoviesSubject.stream;
  Stream<List<Movie>> get nowPlayingMovies => _nowPlayingMoviesSubject.stream;
  Stream<List<Movie>> get upcomingMovies => _upcomingMoviesSubject.stream;

  load() async {
    await _popularMovies();
    await _topRatedMovies();
    await _nowPlayingMovies();
    await _upcomingMovies();
  }

  dispose() {
    _popularMoviesSubject.close();
    _topRatedMoviesSubject.close();
    _nowPlayingMoviesSubject.close();
    _upcomingMoviesSubject.close();
  }

  _popularMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.popularMovies(options);
    logger.i(response);
    _popularMoviesSubject.sink.add(response.results);
  }

  _topRatedMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.topRatedMovies(options);
    logger.i(response);
    _topRatedMoviesSubject.sink.add(response.results);
  }

  _nowPlayingMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.nowPlaying(options);
    logger.i(response);
    _nowPlayingMoviesSubject.sink.add(response.results);
  }

  _upcomingMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.upcomingMovies(options);
    logger.i(response);
    _upcomingMoviesSubject.sink.add(response.results);
  }
}

final homeBloc = HomeBloc();
