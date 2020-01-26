
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviedb/ui/discover/dicover_bloc.dart';
import 'package:moviedb/ui/discover/discover_event.dart';
import 'package:moviedb/ui/discover/discover_screen.dart';
//import 'package:flutter_flipperkit/flipper_client.dart';
//import 'package:flutter_flipperkit/plugins/network/flipper_network_plugin.dart';

import 'api/movie_db_service.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:logger/logger.dart';

import 'ui/bloc/simple_bloc_delegate.dart';


void main() {
//  FlipperClient flipperClient = FlipperClient.getDefault();
//  flipperClient.addPlugin(new FlipperNetworkPlugin(
//      filter: (HttpClientRequest request) {
//        return true;
//      }
//  ));
//  flipperClient.start();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: BlocProvider<DiscoverBloc>(
        create: (context) => DiscoverBloc()..add(DiscoverFetch(page: 1)),
        child: DiscoverScreen(),
      ),
    );
  }
}