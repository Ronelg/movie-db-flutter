class DiscoverState {}

class DiscoverInitial extends DiscoverState {}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoaded extends DiscoverState {
//  final DiscoverResult result;

//  DiscoverPopulated(this.result);
}

class DiscoverEmpty extends DiscoverState {}

class DiscoverError extends DiscoverState {}
