

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
  RxString searchKeyword = "".obs;

  late MoviedbProvider provider;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    this.provider = MoviedbProvider(
      apiKey: dotenv.env['MOVIE_DB_API_KEY']
    );
  }

  Future<MoviePaginator> loadTrendingMovies({page: 1, forceRefresh: false}) async {
      this.viewMode.value = ViewMode.Trending;
      try {
        Response response = await provider.trending(page: page);
        MoviePaginator paginator = MoviePaginator.fromJson(response.body);
        this.trendingMoviesPaginator.value = paginator;
        if(forceRefresh){
          trendingMovies.clear();
        }
        trendingMovies.addAll(paginator.results);
        return Future.value(paginator);
      } catch (error){
        return Future.error(error);
      }
  }

  Future<MoviePaginator> searchMovie({keyword: String, page: 1 , forceRefresh: false}) async {
    this.viewMode.value = ViewMode.Search;
    try {
      Response response = await provider.search(query: keyword, page: page);
      MoviePaginator paginator = MoviePaginator.fromJson(response.body);
      this.searchMoviesPaginator.value = paginator;
      this.searchKeyword.value = keyword;
      if(forceRefresh){
        movieResults.clear();
      }
      movieResults.addAll(paginator.results);
      return Future.value(paginator);
    } catch(error) {
      return Future.error(error);
    }
  }
}

