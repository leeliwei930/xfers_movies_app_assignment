

import 'package:get/get.dart';
import 'package:xfers_movie_assignment/models/movie.dart';
import 'package:xfers_movie_assignment/providers/moviedb_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xfers_movie_assignment/models/movie_paginator.dart';
enum ViewMode {
  Search,
  Trending
}

class MovieController extends GetxController {

  Rx<ViewMode> viewMode = ViewMode.Trending.obs;
  RxList<Movie> trendingMovies = <Movie> [].obs;
  RxList<Movie> movieResults = <Movie>[].obs;
  Rx<MoviePaginator?> trendingMoviesPaginator = null.obs;
  Rx<MoviePaginator?> searchMoviesPaginator = null.obs;

  RxBool isLoading = false.obs;
  RxBool pageLoading = false.obs;
  RxString searchKeyword = "".obs;

  late MoviedbProvider provider;
  @override
  MovieController onInit()  {
    // TODO: implement onInit
    super.onInit();
    this.provider = MoviedbProvider(
      apiKey: dotenv.env['MOVIE_DB_API_KEY']
    )..onInit();
     this.loadTrendingMovies(forceRefresh: true);
    return this;
  }
  Rx<MoviePaginator?> get currentPaginator {
    if(viewMode.value == ViewMode.Trending){
      return trendingMoviesPaginator;
    }
    return searchMoviesPaginator;
  }

  void setViewMode(ViewMode viewMode){
    this.viewMode.value = viewMode;
  }

  void resetSearchResults(){
    this.searchKeyword.value = "";
    this.movieResults.clear();
  }
  Future<MoviePaginator> loadTrendingMovies({page: 1, forceRefresh: false, clearPreviousResult: false}) async {
      this.searchKeyword.value = "";
      if(forceRefresh){
        this.isLoading.trigger(true);
      }
      // if load the second page onward, trigger section based loading indicator
      if(page > 1){
        this.pageLoading.trigger(true);
      }
      try {
        Response response = await provider.trending(page: page);
        this.pageLoading.trigger(false);

        MoviePaginator paginator = MoviePaginator.fromJson(response.body);
        if(clearPreviousResult){
          trendingMovies.clear();
        }
        trendingMovies.addAll(paginator.results);
        this.trendingMoviesPaginator = paginator.obs;

        this.isLoading.trigger(false);

        return Future.value(paginator);
      } catch (error){
        this.isLoading.trigger(false);
        this.pageLoading.trigger(false);


        return Future.error(error);
      }
  }

  Future<MoviePaginator> searchMovie({keyword: String, page: 1 , forceRefresh: false, clearPreviousResult: false}) async {
    if(forceRefresh){
      this.isLoading.trigger(true);
    }
    // if load the second page onward, trigger section based loading indicator
    if(page > 1){
      this.pageLoading.trigger(true);
    }
    try {
      Response response = await provider.search(query: keyword, page: page);
      MoviePaginator paginator = MoviePaginator.fromJson(response.body);
      this.searchKeyword.value = keyword;
      if(clearPreviousResult){
        movieResults.clear();
      }
      movieResults.addAll(paginator.results);
      this.searchMoviesPaginator = paginator.obs;

      this.isLoading.trigger(false);
      this.pageLoading.trigger(false);

      return Future.value(paginator);
    } catch(error) {
      this.isLoading.trigger(false);
      this.pageLoading.trigger(false);

      return Future.error(error);
    }
  }
}

