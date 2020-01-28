import 'package:moviedb/api/movie_db_service.dart';
import 'package:moviedb/model/movies_response.dart';

class MovieDbRepository {
  MovieDbService service;

  MovieDbRepository({this.service});

  Future<MoviesResponse> discover(Map<String, String> options) {
    return this.service.discover(options);
  }

  Future<MoviesResponse> nowPlaying(Map<String, String> options) {
    return this.service.nowPlaying(options);
  }

  Future<MoviesResponse> topRatedMovies(Map<String, String> options) {
    return this.service.topRatedMovies(options);
  }

  Future<MoviesResponse> popularMovies(Map<String, String> options) {
    return this.service.popularMovies(options);
  }

  Future<MoviesResponse> upcomingMovies(Map<String, String> options) {
    return this.service.upcomingMovies(options);
  }
}
