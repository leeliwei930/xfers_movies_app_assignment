import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xfers_movie_assignment/xfers_movie_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(XfersMovieApp());
}
