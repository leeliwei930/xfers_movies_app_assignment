
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xfers_movie_assignment/services/translation_service.dart';
import 'package:xfers_movie_assignment/views/home_view.dart';

import 'constants/themes.dart';

class XfersMovieApp extends StatefulWidget {

  _XfersMovieAppState createState() => _XfersMovieAppState();
}


class _XfersMovieAppState extends State<XfersMovieApp> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetMaterialApp(
      translations: TranslationService(),
      fallbackLocale: Locale("en_US"),
      locale: Locale("en_US"),
      home: HomeView(),
      theme: kDefaultTheme
    );
  }
}
