
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xfers_movie_assignment/components/movie_card.dart';
import 'package:xfers_movie_assignment/constants/layout.dart';
import 'package:xfers_movie_assignment/controllers/movie_controller.dart';
import 'package:xfers_movie_assignment/models/movie.dart';

class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {

  late MovieController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.controller = Get.put(MovieController()..onInit());

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Movie App"),
      ),
      body: Container(
        child: Obx(() => ListView.separated(
            padding: kDefaultPadding,
            itemBuilder: buildMoviesList,
            separatorBuilder: (BuildContext context, int index){
              return Divider();
            },
            itemCount: controller.viewMode() == ViewMode.Trending ? controller.trendingMovies.length : controller.movieResults.length
        )),
      )
    );
  }

  Widget buildMoviesList(BuildContext context, int index){
    late Movie movie;
    if(controller.viewMode() == ViewMode.Trending){
      movie = controller.trendingMovies.elementAt(index);
    } else {
      movie = controller.movieResults.elementAt(index);
    }
    return MovieCard(movie: movie,);
  }

}
