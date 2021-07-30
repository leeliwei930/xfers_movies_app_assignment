
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xfers_movie_assignment/views/home_view.dart';

class XfersMovieApp extends StatefulWidget {

  _XfersMovieAppState createState() => _XfersMovieAppState();
}


class _XfersMovieAppState extends State<XfersMovieApp> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      home: HomeView()
    );
  }
}
