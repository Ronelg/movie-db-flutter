
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/injection.dart';
import 'package:rxdart/rxdart.dart';


class DiscoverBloc {
  final _repository = Injector.provideMovieRepository();
  final _moviesFetcher = PublishSubject<MoviesResponse>();

  Stream<MoviesResponse> get allMovies => _moviesFetcher.stream;

  fetchAllMovies() async {
    Map<String, String> options = Map<String, String>();
//    options['sort_by']=  "popularity.desc";
//    options['primary_release_year']=  "2018";

    var response = await _repository.discover(options);
    _moviesFetcher.sink.add(response);
  }

  dispose() {
    _moviesFetcher.close();
  }
}

//final bloc = DiscoverBloc();