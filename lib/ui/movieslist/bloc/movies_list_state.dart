import 'package:equatable/equatable.dart';
import 'package:moviedb/model/movie.dart';
import 'package:meta/meta.dart';

abstract class MoviesListState extends Equatable {
  const MoviesListState();

  @override
  List<Object> get props => [];
}

class MoviesListUninitialized extends MoviesListState {}

class MoviesListLoading extends MoviesListState {}

class MoviesListLoaded extends MoviesListState {
  final List<Movie> movies;
  final int page;

  const MoviesListLoaded({@required this.movies, @required this.page});

  @override
  List<Object> get props => [movies, page];

  @override
  String toString() => 'MoviesList Loaded { items: ${movies.length} page: $page }';
}

class MoviesListError extends MoviesListState {
  final String message;

  const MoviesListError({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'MoviesList Error { message: $message }';
}
