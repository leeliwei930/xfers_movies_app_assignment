
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xfers_movie_assignment/components/card_message.dart';
import 'package:xfers_movie_assignment/components/movie_card.dart';
import 'package:xfers_movie_assignment/components/pagination_bar.dart';
import 'package:xfers_movie_assignment/components/search_result_bar.dart';
import 'package:xfers_movie_assignment/constants/layout.dart';
import 'package:xfers_movie_assignment/controllers/movie_controller.dart';
import 'package:xfers_movie_assignment/delegate/movie_search_delegate.dart';
import 'package:xfers_movie_assignment/models/error.dart';
import 'package:xfers_movie_assignment/models/movie.dart';
import 'package:xfers_movie_assignment/models/movie_paginator.dart';

class HomeView extends StatefulWidget {
  _HomeViewState createState() => _HomeViewState();
}


class _HomeViewState extends State<HomeView> with TickerProviderStateMixin{

  late MovieController controller;
  late ScrollController _scrollController;
  late AnimationController _paginationBarAnimationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.controller = Get.put(MovieController()..onInit());
    this._scrollController = ScrollController();

    this._scrollController.addListener(listenListScrollEvent);
    this._paginationBarAnimationController = AnimationController(vsync: this,duration: Duration(milliseconds: 850));
  }

  // listen to the list scrolling event to determine when to load the next pages
  void listenListScrollEvent() async {
    // if the scrolling position reached the bottom
    if(this._scrollController.offset >= this._scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange){
      MoviePaginator? currentPaginator = controller.currentPaginator();

      if(controller.viewMode() == ViewMode.Trending){
        if(currentPaginator != null){
          await controller.loadTrendingMovies(page: currentPaginator.page + 1);
          this._paginationBarAnimationController.forward();
          await Future.delayed(Duration(milliseconds: 1250));
          this._paginationBarAnimationController.reverse();
        }
      } else {
        if(currentPaginator != null){
          await controller.searchMovie(
              keyword: controller.searchKeyword(), page: currentPaginator.page + 1
          );
        }
      }
    }
  }

  Future<void> forceRefreshMovies() async {
    if(controller.viewMode() == ViewMode.Trending){
        await controller.loadTrendingMovies(page: 1 , clearPreviousResult: true);
    } else {
      await controller.searchMovie(
          keyword: controller.searchKeyword(), page: 1 , clearPreviousResult: true
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    _paginationBarAnimationController.addListener(() {
      setState(() {
      });
    });
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Movie App"),
          actions: [
            IconButton(onPressed: () => handleSearch(), icon: Icon(Icons.search))
          ],
        ),
        body: Container(
            child: RefreshIndicator(
              onRefresh:  forceRefreshMovies,
              child: Obx((){
                late int itemCount;
                if(controller.isLoading()){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(controller.searchError() != null && controller.searchKeyword().length > 0){
                  Error error = controller.searchError()!;
                  return Center(
                    child: CardMessage(
                      icon: Icon(error.icon, size: 48, color: Colors.amber,),
                      message: error.message,
                      onRetry: () async {
                        await this.controller.searchMovie(keyword: controller.searchKeyword(), forceRefresh: true, clearPreviousResult: true);
                      },
                    ),
                  );
                }
                if(controller.trendingMoviesError() != null){
                  Error error = controller.trendingMoviesError()!;
                  return Center(
                    child: CardMessage(
                      icon: Icon(error.icon, size: 48, color: Colors.amber,),
                      message: error.message,
                      onRetry: ()  {
                         this.controller.loadTrendingMovies(forceRefresh: true, clearPreviousResult: true);
                      },
                    ),
                  );
                }

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

                ],
                );
              }),
            )
        ),
        extendBody: true,
        bottomNavigationBar: Obx(() => buildBottomBar())
    );
  }

  Widget buildBottomBar(){
    if(controller.viewMode() == ViewMode.Trending){
      return FadeTransition(
          opacity: _paginationBarAnimationController,
          child: Builder(
            builder: (BuildContext context){
              if(controller.currentPaginator() != null){
                MoviePaginator paginator = controller.currentPaginator()!;
                return PaginationBar(
                    loadingPage: paginator.page,
                    totalPages: paginator.totalPages
                );
              } else {
                return Container();
              }
            },
          )
      );
    } else if (controller.viewMode() == ViewMode.Search){
      return SearchResultBar(
        isLoading: controller.pageLoading(),
        keyword: controller.searchKeyword(),
        totalResults: controller.searchMoviesPaginator()!.totalResults.toInt(),
        loadedResults: controller.movieResults().length,
        onClear: clearSearchResults,
      );
    }
    return Container();
  }

  Widget buildMoviesList(BuildContext context, int index){
    late Movie movie;
    // render the movie card based on the view mode
    if(controller.viewMode() == ViewMode.Trending){
      movie = controller.trendingMovies.elementAt(index);
    } else {
      movie = controller.movieResults.elementAt(index);
    }
    return MovieCard(movie: movie,);
  }

  void clearSearchResults() async {
      await this.controller.loadTrendingMovies(forceRefresh: true, clearPreviousResult: true);
      controller.setViewMode(ViewMode.Trending);
      controller.resetSearchResults();
  }

  void handleSearch() async {
    String query = await showSearch(
        context: context,
        delegate: MovieSearchDelegate<String>(),
        query:  controller.searchKeyword()
    );
    if(query.length > 0){
      await controller.searchMovie(keyword: query, clearPreviousResult: true);
      controller.setViewMode(ViewMode.Search);
    } else {
      controller.setViewMode(ViewMode.Trending);
    }
  }
}
