import 'package:moviedb/api/movie_db_service.dart';
import 'package:moviedb/model/movie_credits_response.dart';
import 'package:moviedb/model/movie_details_response.dart';
import 'package:moviedb/model/movie_videos_response.dart';
import 'package:moviedb/model/movies_response.dart';

class MovieDbRepository {
  MovieDbService service;

  MovieDbRepository({this.service});

  Future<MoviesResponse> discover(Map<String, String> options) {
    return this.service.discover(options);
  }

  Future<MoviesResponse> nowPlaying(Map<String, String> options) {
    return this.service.nowPlaying(options);
  }

  Future<MoviesResponse> topRatedMovies(Map<String, String> options) {
    return this.service.topRatedMovies(options);
  }

  Future<MoviesResponse> popularMovies(Map<String, String> options) {
    return this.service.popularMovies(options);
  }

  Future<MoviesResponse> upcomingMovies(Map<String, String> options) {
    return this.service.upcomingMovies(options);
  }

  Future<MovieDetailsResponse> movieDetails(String id, Map<String, String> options) {
    return this.service.getMovieDetails(id, options);
  }

  Future<MovieVideosResponse> movieVideos(String id, Map<String, String> options) {
    return this.service.getMovieVideos(id, options);
  }

  Future<MoviesResponse> similarMovies(String id, Map<String, String> options) {
    return this.service.getMovieSimilar(id, options);
  }

  Future<MovieCreditsResponse> movieCredits(String id, Map<String, String> options) {
    return this.service.getMovieCredits(id, options);
  }
}
