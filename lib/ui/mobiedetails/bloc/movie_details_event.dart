
import 'package:equatable/equatable.dart';
import 'package:moviedb/model/movie.dart';

abstract class MovieDetailsEvent extends Equatable {
  const MovieDetailsEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailMovieEvent extends MovieDetailsEvent {
  final Movie movie;

  const MovieDetailMovieEvent(this.movie);

  @override
  String toString() => 'Movie Detail Movie Event {movie: $movie}';
}

class MovieDetailFetchEvent extends MovieDetailsEvent {
  const MovieDetailFetchEvent();

  @override
  String toString() => 'Movie Detail Fetch Event';
}
