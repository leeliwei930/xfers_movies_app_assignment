

import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:xfers_movie_assignment/models/error.dart';
import 'package:xfers_movie_assignment/models/movie.dart';
import 'package:xfers_movie_assignment/providers/moviedb_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xfers_movie_assignment/models/movie_paginator.dart';
enum ViewMode {
  Search,
  Trending
}

class MovieController extends GetxController {
  // display mode and search keyword state
  Rx<ViewMode> viewMode = ViewMode.Trending.obs;
  RxString searchKeyword = "".obs;

  // movies list state
  RxList<Movie> trendingMovies = <Movie> [].obs;
  RxList<Movie> movieResults = <Movie>[].obs;

  // List paginator state
  Rx<MoviePaginator?> trendingMoviesPaginator = null.obs;
  Rx<MoviePaginator?> searchMoviesPaginator = null.obs;

  // page loading state
  RxBool isLoading = false.obs;
  RxBool pageLoading = false.obs;
  RxBool searchSuggestionLoading = false.obs;

  late MoviedbProvider provider;

  // error state
  Rx<Error?> searchError = null.obs;
  Rx<Error?> trendingMoviesError = null.obs;
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
  Future<void> loadTrendingMovies({page: 1, forceRefresh: false, clearPreviousResult: false}) async {
      this.searchKeyword.value = "";
      if(forceRefresh){
        this.isLoading.trigger(true);
      }
      // if load the second page onward, trigger section based loading indicator
      if(page > 1){
        this.pageLoading.trigger(true);
      }

        this.trendingMoviesError = null.obs;
        try {

          Response response = await provider.trending(page: page);
          if(!response.hasError){

            MoviePaginator paginator = MoviePaginator.fromJson(response.body);
            if(clearPreviousResult){
              trendingMovies.clear();
            }
            trendingMovies.addAll(paginator.results);
            this.trendingMoviesPaginator = paginator.obs;

          } else {
            print(response.statusText!);
            this.trendingMoviesError = Error.mapErrorMessageToLabel(response.statusText!).obs;
          }

        } catch(exception){
          if(exception is TimeoutException){
            this.trendingMoviesError = Error.mapErrorMessageToLabel("TimeoutException").obs;
          }
        } finally {
          this.isLoading.trigger(false);
          this.pageLoading.trigger(false);

        }





  }

  Future<void> searchMovie({keyword: String, page: 1 , forceRefresh: false, clearPreviousResult: false}) async {
    if(forceRefresh){
      this.isLoading.trigger(true);
    }
    this.searchSuggestionLoading.trigger(true);
    // if load the second page onward, trigger section based loading indicator
    if(page > 1){
      this.pageLoading.trigger(true);
    }
      this.searchError = null.obs;
      try {
        Response response = await provider.search(query: keyword, page: page);
        if(!response.hasError){
          MoviePaginator paginator = MoviePaginator.fromJson(response.body);
          this.searchKeyword.value = keyword;
          if(clearPreviousResult){
            movieResults.clear();
          }
          movieResults.addAll(paginator.results);
          this.searchMoviesPaginator = paginator.obs;
        } else {
          this.searchError = Error.mapErrorMessageToLabel(response.statusText!).obs;

        }
      } catch(error) {
        if(error is TimeoutException){
          this.searchError = Error.mapErrorMessageToLabel("TimeoutException").obs;
        }
      } finally {
        this.isLoading.trigger(false);
        this.pageLoading.trigger(false);
        this.searchSuggestionLoading.trigger(false);

      }




  }
}

