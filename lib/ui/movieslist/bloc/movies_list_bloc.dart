import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moviedb/model/collection_type.dart';
import 'package:moviedb/model/collection_type.dart';
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
          final MoviesResponse response = await _fetchMovies(1, event);
          yield MoviesListLoaded(movies: response.results, page: response.page);
        }

        if (currentState is MoviesListLoaded) {
          final MoviesResponse response = await _fetchMovies(currentState.page + 1, event);
          yield MoviesListLoaded(
              movies: currentState.movies + response.results, page: response.page);
        }
      } catch (err) {
        _logger.i(err);
        yield MoviesListError(message: err.toString());
      }
    }

    if (event is ClearState) {
      yield MoviesListUninitialized();
    }
  }

  _fetchMovies(int page, MoviesListFetch event) async {
    Map<String, String> options = Map<String, String>();
    options['page'] = page.toString();

    var response = await _mapCollectionTypeToRequest(event.collectionType, options);
//    var response = await _repository.discover(options);
    return response;
  }

  _mapCollectionTypeToRequest(CollectionType collectionType, Map<String, String> options) async {
    if (collectionType == CollectionType.PopularMovies) {
      return _repository.popularMovies(options);
    } else if (collectionType == CollectionType.UpcomingMovies) {
      return _repository.upcomingMovies(options);
    } else if (collectionType == CollectionType.TopRatedMovies) {
      return _repository.topRatedMovies(options);
    } else if (collectionType == CollectionType.NowPlayingMovies) {
      return _repository.nowPlaying(options);
    } else {
      _repository.discover(options);
    }
  }
}
