import 'package:equatable/equatable.dart';

abstract class MoviesListEvent extends Equatable {
  const MoviesListEvent();

  @override
  List<Object> get props => [];
}

class MoviesListFetch extends MoviesListEvent {
  const MoviesListFetch();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'Discover Fetch';
}