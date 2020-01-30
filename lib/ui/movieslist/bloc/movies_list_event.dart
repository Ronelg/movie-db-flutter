import 'package:equatable/equatable.dart';
import 'package:moviedb/model/collection_type.dart';

abstract class MoviesListEvent extends Equatable {
  const MoviesListEvent();

  @override
  List<Object> get props => [];
}

class MoviesListFetch extends MoviesListEvent {
  final CollectionType collectionType;

  const MoviesListFetch(this.collectionType);

  @override
  List<Object> get props => [collectionType];

  @override
  String toString() => 'MoviesList Fetch { collectionType: $collectionType }';
}

class ClearState extends MoviesListEvent {
  const ClearState();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'MoviesList Clear';
}