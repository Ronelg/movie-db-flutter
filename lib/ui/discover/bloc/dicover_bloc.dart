import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/injection.dart';

import 'discover_event.dart';
import 'discover_state.dart';

class DiscoverBloc extends Bloc<DiscoverEvent, DiscoverState> {
  final _repository = Injector.provideMovieRepository();
  final _logger = Logger();

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
          yield DiscoverLoaded(movies: currentState.movies + response.results, page: response.page);
        }
      } catch (err) {
        _logger.i(err);
        yield DiscoverError(message: err.toString());
      }
    }
  }

  _fetchMovies1(int page) async {
    Map<String, String> options = Map<String, String>();
    options['sort_by'] = "popularity.desc";
//    options['primary_release_year']=  "2018";
    options['page'] = page.toString();

    var response = await _repository.discover(options);
    return response;
  }
}
