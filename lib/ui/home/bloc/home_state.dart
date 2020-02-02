import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/model/movie.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeUninitialized extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Movie> nowPlaying;
  final List<Movie> topRatedMovies;
  final List<Movie> popularMovies;
  final List<Movie> upcomingMovies;

  const HomeLoaded({
    this.nowPlaying,
    this.topRatedMovies,
    this.popularMovies,
    this.upcomingMovies,
  });

  HomeLoaded copyWith({
    List<Movie> nowPlaying,
    List<Movie> topRatedMovies,
    List<Movie> popularMovies,
    List<Movie> upcomingMovies,
  }) {
    return HomeLoaded(
      nowPlaying: nowPlaying ?? this.nowPlaying,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
    );
  }

  @override
  List<Object> get props => [nowPlaying, topRatedMovies, popularMovies, upcomingMovies];

  @override
  String toString() => 'Home Loaded { '
      'nowPlaying: ${nowPlaying?.length} '
      'topRatedMovies: ${topRatedMovies?.length} '
      'popularMovies: ${popularMovies?.length} '
      'upcomingMovies: ${upcomingMovies?.length}  }';
}

class HomeError extends HomeState {
  final String message;

  const HomeError({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'Home Error { message: $message }';
}
