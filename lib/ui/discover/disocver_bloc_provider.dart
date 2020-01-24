import 'package:flutter/cupertino.dart';
import 'package:moviedb/ui/discover/dicover_bloc.dart';

import 'dicover_bloc.dart';

class DiscoverBlocProvider extends InheritedWidget {
  final DiscoverBloc bloc;

  DiscoverBlocProvider({Key key, Widget child})
      : bloc = DiscoverBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return null;
  }

  static DiscoverBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DiscoverBlocProvider) as DiscoverBlocProvider)
        .bloc;
  }
}
