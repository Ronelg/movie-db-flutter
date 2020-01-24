import 'package:moviedb/api/movie_db_service.dart';
import 'package:moviedb/repository/movie_db_repository.dart';

class Injector {

  static MovieDbService provideService() {
     return MovieDbService.instance;
  }

  static MovieDbRepository provideMovieRepository() {
    var service = MovieDbService.instance;
    return MovieDbRepository(service: service);
  }
}