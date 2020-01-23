import 'package:moviedb/api/movie_db_service.dart';
import 'package:moviedb/model/movies_response.dart';

class MovieDbRepository {
  MovieDbService service;

  MovieDbRepository() {
    this.service = MovieDbService.instance;
  }

  Future<MoviesResponse> discover() {
    return this.service.discover();
  }
}
