
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/repository/movie_db_repository.dart';
import 'package:rxdart/rxdart.dart';


class DiscoverBloc {
  final _repository = MovieDbRepository();
  final _moviesFetcher = PublishSubject<MoviesResponse>();

  Stream<MoviesResponse> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    var response = await _repository.discover();
    _moviesFetcher.sink.add(response);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

final bloc = DiscoverBloc();