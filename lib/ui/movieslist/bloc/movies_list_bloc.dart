
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moviedb/model/movies_response.dart';

import '../../injection.dart';
import 'movies_list_event.dart';
import 'movies_list_state.dart';

class MoviesListBloc extends Bloc<MoviesListEvent, MoviesListState> {
  final _repository = Injector.provideMovieRepository();
  final _logger = Logger();

  @override
  MoviesListState get initialState => MoviesListUninitialized();

  @override
  Stream<MoviesListState> mapEventToState(MoviesListEvent event) async* {
    final currentState = state;

    if (event is MoviesListFetch) {
      try {
        if (currentState is MoviesListUninitialized) {
          final MoviesResponse response = await _fetchMovies(1);
          yield MoviesListLoaded(movies: response.results, page: response.page);
        }

        if (currentState is MoviesListLoaded) {
          final MoviesResponse response = await _fetchMovies(currentState.page + 1);
          yield MoviesListLoaded(movies: currentState.movies + response.results, page: response.page);
        }
      } catch (err) {
        _logger.i(err);
        yield MoviesListError(message: err.toString());
      }
    }
  }

  _fetchMovies(int page) async {
    Map<String, String> options = Map<String, String>();
    options['sort_by'] = "popularity.desc";
    options['page'] = page.toString();

    var response = await _repository.discover(options);
    return response;
  }
}