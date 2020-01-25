import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:moviedb/model/movie.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class DiscoverUninitialized extends DiscoverState {}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoaded extends DiscoverState {
  final List<Movie> movies;
  final int page;

  const DiscoverLoaded({@required this.movies, @required this.page});

  @override
  List<Object> get props => [movies];

  @override
  String toString() => 'Discover Loaded { items: ${movies.length} }';
}

class DiscoverError extends DiscoverState {}