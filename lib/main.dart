import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/ui/discover/bloc/dicover_bloc.dart';
import 'package:moviedb/ui/discover/bloc/discover_event.dart';
import 'package:moviedb/ui/home/home_screen.dart';
import 'package:moviedb/ui/movieslist/bloc/movies_list_bloc.dart';

import 'ui/bloc/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  var appProvider = MultiBlocProvider(
    providers: [
      BlocProvider<DiscoverBloc>(
        create: (context) => DiscoverBloc()..add(DiscoverFetch()),
      ),
      BlocProvider<MoviesListBloc>(
        create: (context) => MoviesListBloc(),
      ),
    ],
    child: MyApp(),
  );

  runApp(appProvider);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),

//      home: BlocProvider<DiscoverBloc>(
//        create: (context) => DiscoverBloc()..add(DiscoverFetch()),
//        child: HomeBlocProvider(
//          child: HomeScreen(),
//        ),
////        child: DiscoverScreen(),
//      ),
    );
  }
}
