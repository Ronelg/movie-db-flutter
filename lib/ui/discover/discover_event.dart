import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class DiscoverEvent extends Equatable {
  const DiscoverEvent();

  @override
  List<Object> get props => [];
}

class DiscoverFetch extends DiscoverEvent {
  final int page;

  const DiscoverFetch({@required this.page});

  @override
  List<Object> get props => [page];

  @override
  String toString() => 'Discover Fetch { page: $page }';
}
