
import 'package:flutter/material.dart';
import 'package:xfers_movie_assignment/constants/layout.dart';

class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Movie App"),
      ),
      body: Container(
        padding: kDefaultPadding,
        child: Column(
          children: [
            Text("")
          ],
        ),
      ),
    );
  }
}
