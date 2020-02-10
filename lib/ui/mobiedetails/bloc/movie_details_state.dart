import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/model/movie.dart';
import 'package:moviedb/model/movie_credits_response.dart';
import 'package:moviedb/model/movie_details_response.dart';
import 'package:moviedb/model/movie_videos_response.dart';
import 'package:moviedb/model/movies_response.dart';

abstract class MovieDetailsState extends Equatable {
  const MovieDetailsState();

  @override
  List<Object> get props => [];
}

class MovieDetailsUninitialized extends MovieDetailsState {}

class MovieDetailLoading extends MovieDetailsState {}

class MovieDetailsMovieUpdated extends MovieDetailsState {}

class MovieDetailLoaded extends MovieDetailsState {
  final Movie movie;
  final MovieDetailsResponse details;
  final MovieVideosResponse videos;
  final MovieCreditsResponse credits;
  final MoviesResponse similar;

  MovieDetailLoaded({
    this.movie,
    this.credits,
    this.details,
    this.videos,
    this.similar,
  });

  MovieDetailLoaded copyWith({
    Movie movie,
    MovieDetailsResponse details,
    MovieVideosResponse videos,
    MovieCreditsResponse credits,
    MoviesResponse similar,
  }) {
    return MovieDetailLoaded(
      movie: movie ?? this.movie,
      details: details ?? this.details,
      credits: credits ?? this.credits,
      videos: videos ?? this.videos,
      similar: similar ?? this.similar,
    );
  }

  @override
  List<Object> get props => [movie, details, credits, videos];

  @override
  String toString() => 'MovieDetail Loaded { '
      'movie: { $movie } '
      'details: { $details } '
      'credits: { $credits } '
      'videos: { $videos }  }'
      'videos: { $similar }  }';
}

class MovieDetailsError extends MovieDetailsState {
  final String message;

  const MovieDetailsError({@required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'MovieDetails Error { message: $message }';
}
