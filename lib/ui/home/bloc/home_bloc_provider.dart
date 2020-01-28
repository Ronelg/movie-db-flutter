import 'package:flutter/cupertino.dart';
import 'package:moviedb/ui/home/bloc/home_bloc.dart';

class HomeBlocProvider extends InheritedWidget {
  final HomeBloc bloc;

  HomeBlocProvider({Key key, Widget child})
      : bloc = HomeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) {
    return true;
  }

  static HomeBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<HomeBlocProvider>()).bloc;
  }
}
