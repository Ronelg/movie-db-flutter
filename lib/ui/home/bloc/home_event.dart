import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeFetchNowPlaying extends HomeEvent {
  const HomeFetchNowPlaying();

  @override
  String toString() => 'Home Fetch Now Playing';
}

class HomeFetchPopularMovies extends HomeEvent {
  const HomeFetchPopularMovies();

  @override
  String toString() => 'Home Fetch Popular Movies';
}

class HomeFetchTopRated extends HomeEvent {
  const HomeFetchTopRated();

  @override
  String toString() => 'Home Fetch Top Rated';
}

class HomeFetchUpcoming extends HomeEvent {
  const HomeFetchUpcoming();

  @override
  String toString() => 'Home Fetch Upcoming';
}
