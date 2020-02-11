import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/model/movie_credits_response.dart';
import 'package:moviedb/model/movie_details_response.dart';
import 'package:moviedb/model/movie_videos_response.dart';
import 'package:moviedb/model/movies_response.dart';
import 'package:moviedb/ui/mobiedetails/bloc/movie_details_event.dart';
import 'package:moviedb/ui/mobiedetails/bloc/movie_details_state.dart';

import '../../injection.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final _repository = Injector.provideMovieRepository();
  final _logger = Injector.provideLogger();
  Movie movie;

  @override
  MovieDetailsState get initialState => MovieDetailsUninitialized();

  @override
  Stream<MovieDetailsState> mapEventToState(MovieDetailsEvent event) async* {
    final currentState = state;

    try {
      if (currentState is MovieDetailsUninitialized) {
        yield MovieDetailLoading();
      }

      if (event is MovieDetailMovieEvent) {
        this.movie = event.movie;
        yield MovieDetailsMovieUpdated();
      }

      if (event is MovieDetailFetchEvent) {
        MovieDetailsResponse details = await _fetchMovieDetails();
        MovieCreditsResponse credits = await _fetchMovieCredits();
        MovieVideosResponse videos = await _fetchMovieVideos();
        MoviesResponse similar = await _fetchSimilarMovieVideos();

        yield MovieDetailLoaded(
            details: details,credits: credits, videos: videos, similar: similar);

//        yield MovieDetailLoaded(
//            details: details, credits: credits, videos: videos, similar: similar);
      }
    } catch (err) {
      yield MovieDetailsError(message: err.toString());
    }
  }

  _fetchMovieDetails() async {
    Map<String, String> options = Map<String, String>();

    MovieDetailsResponse response = await _repository.movieDetails(movie.id.toString(), options);
    return response;
  }

  _fetchMovieCredits() async {
    Map<String, String> options = Map<String, String>();

    MovieCreditsResponse response = await _repository.movieCredits(movie.id.toString(), options);
    return response;
  }

  _fetchMovieVideos() async {
    Map<String, String> options = Map<String, String>();

    MovieVideosResponse response = await _repository.movieVideos(movie.id.toString(), options);
    return response;
  }

  _fetchSimilarMovieVideos() async {
    Map<String, String> options = Map<String, String>();

    MoviesResponse response = await _repository.similarMovies(movie.id.toString(), options);
    return response;
  }
}
