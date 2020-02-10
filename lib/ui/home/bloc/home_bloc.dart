import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/home/bloc/home_event.dart';
import 'package:moviedb/ui/home/bloc/home_state.dart';

import '../../injection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _repository = Injector.provideMovieRepository();
  final _logger = Injector.provideLogger();

  @override
  HomeState get initialState => HomeUninitialized();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final currentState = state;

    try {
      if (currentState is HomeUninitialized) {
        if (event is HomeFetchNowPlaying) {
          MoviesResponse response = await _nowPlayingMovies();
          yield HomeLoaded(nowPlaying: response.results);
        }

        if (event is HomeFetchPopularMovies) {
          MoviesResponse response = await _popularMovies();
          yield HomeLoaded(popularMovies: response.results);
        }

        if (event is HomeFetchTopRated) {
          MoviesResponse response = await _topRatedMovies();
          yield HomeLoaded(topRatedMovies: response.results);
        }

        if (event is HomeFetchUpcoming) {
          MoviesResponse response = await _upcomingMovies();
          yield HomeLoaded(upcomingMovies: response.results);
        }
      }
      if (currentState is HomeLoaded) {
        if (event is HomeFetchNowPlaying) {
          MoviesResponse response = await _nowPlayingMovies();
          yield currentState.copyWith(nowPlaying: response.results);
        }

        if (event is HomeFetchPopularMovies) {
          MoviesResponse response = await _popularMovies();
          yield currentState.copyWith(popularMovies: response.results);
        }

        if (event is HomeFetchTopRated) {
          MoviesResponse response = await _topRatedMovies();
          yield currentState.copyWith(topRatedMovies: response.results);
        }

        if (event is HomeFetchUpcoming) {
          MoviesResponse response = await _upcomingMovies();
          yield currentState.copyWith(upcomingMovies: response.results);
        }
      }
    } catch (err) {
      yield HomeError(message: err.toString());
    }
  }

  _popularMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.popularMovies(options);
    return response;
  }

  _topRatedMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.topRatedMovies(options);
    return response;
  }

  _nowPlayingMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.nowPlaying(options);
    return response;
  }

  _upcomingMovies() async {
    Map<String, String> options = Map<String, String>();
    options['page'] = "1";

    MoviesResponse response = await _repository.upcomingMovies(options);
    return response;
  }
}
