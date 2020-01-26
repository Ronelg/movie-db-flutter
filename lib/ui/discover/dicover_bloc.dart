import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/injection.dart';
import 'package:rxdart/rxdart.dart';

import 'discover_event.dart';
import 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final _repository = Injector.provideMovieRepository();
  final _moviesFetcher = PublishSubject<MoviesResponse>();
  final logger = Logger();

  Stream<MoviesResponse> get allMovies => _moviesFetcher.stream;

  @override
  DiscoverState get initialState => DiscoverUninitialized();

  @override
  Stream<DiscoverState> mapEventToState(DiscoverEvent event) async* {
    final currentState = state;

    if (event is DiscoverFetch) {
      try {
        if (currentState is DiscoverUninitialized) {
          final MoviesResponse response = await _fetchMovies1(1);
          yield DiscoverLoaded(movies: response.results, page: response.page);
        }

        if (currentState is DiscoverLoaded) {
          final MoviesResponse response = await _fetchMovies1(currentState.page + 1);
          yield DiscoverLoaded(movies: response.results, page: response.page);
        }
      } catch (err) {
        logger.i(err);
        yield DiscoverError();
      }
    }
  }

  dispose() {
    _moviesFetcher.close();
  }

  _fetchMovies() async {
    Map<String, String> options = Map<String, String>();
//    options['sort_by']=  "popularity.desc";
//    options['primary_release_year']=  "2018";

    var response = await _repository.discover(options);
    _moviesFetcher.sink.add(response);
  }

  _fetchMovies1(int page) async {
    Map<String, String> options = Map<String, String>();
    options['sort_by'] = "popularity.desc";
//    options['primary_release_year']=  "2018";

    var response = await _repository.discover(options);
    return response;
  }
}

//final bloc = DiscoverBloc();
