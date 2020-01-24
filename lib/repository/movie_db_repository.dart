import 'package:moviedb/api/movie_db_service.dart';
import 'package:moviedb/model/movies_response.dart';

class MovieDbRepository {
  MovieDbService service;

  MovieDbRepository({this.service});

  Future<MoviesResponse> discover(Map<String, String> options) {
    return this.service.discover(options);
  }
}
