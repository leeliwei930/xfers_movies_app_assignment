
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xfers_movie_assignment/components/movie_card.dart';
import 'package:xfers_movie_assignment/constants/layout.dart';
import 'package:xfers_movie_assignment/controllers/movie_controller.dart';
import 'package:xfers_movie_assignment/models/movie.dart';
import 'package:xfers_movie_assignment/models/movie_paginator.dart';

class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> {

  late MovieController controller;
  late ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.controller = Get.put(MovieController()..onInit());
    this._scrollController = ScrollController();

    this._scrollController.addListener(listenListScrollEvent);
  }

  // listen to the list scrolling event to determine whether to load the next pages
  void listenListScrollEvent(){
    // if the scrolling position reached the bottom
    if(this._scrollController.offset >= this._scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange){
      if(controller.viewMode() == ViewMode.Trending){
        MoviePaginator? currentTrendingPaginator = controller.trendingMoviesPaginator();
        if(currentTrendingPaginator != null){
          controller.loadTrendingMovies(page: currentTrendingPaginator.page + 1);
        }
      }
    }
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
            child: Obx((){
              if(controller.isLoading()){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              late int itemCount;
              if(controller.viewMode() == ViewMode.Trending){
                itemCount = controller.trendingMovies.length;
              } else {
                itemCount =  controller.movieResults.length;
              }
              return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        padding: kDefaultPadding,
                        itemBuilder: buildMoviesList,
                        separatorBuilder: (BuildContext context, int index){
                          return Divider();
                        },
                        itemCount: itemCount
                      ),
                    ),
                    if(controller.pageLoading())
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: LinearProgressIndicator(),
                      )
              ],
              );
            })
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
