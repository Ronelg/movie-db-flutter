
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/injection.dart';
import 'package:rxdart/rxdart.dart';


class DiscoverBloc {
  final _repository = Injector.provideMovieRepository();
  final _moviesSubject = PublishSubject<MoviesResponse>();

  Stream<MoviesResponse> get allMovies => _moviesSubject.stream;

  fetchMovies() async {
    Map<String, String> options = Map<String, String>();
//    options['sort_by']=  "popularity.desc";
//    options['primary_release_year']=  "2018";
//    options['page']=  "1";

    var response = await _repository.discover(options);
    _moviesSubject.sink.add(response);
  }

  dispose() {
    _moviesSubject.close();
  }

}