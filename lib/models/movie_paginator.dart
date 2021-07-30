import 'package:json_annotation/json_annotation.dart';

import 'movie.dart';

part 'movie_paginator.g.dart';

@JsonSerializable()
class MoviePaginator {

  @JsonKey(name: "page")
  late int page;

  @JsonKey(name: "results", fromJson: _parseMovieList)
  late List<Movie> results;

  @JsonKey(name: "total_pages")
  late int totalPages;

  @JsonKey(name: "total_results")
  late int totalResults;

  MoviePaginator({required this.page, required this.results,
    required this.totalPages, required this.totalResults});

  static List<Movie> _parseMovieList(List<dynamic> movies){
    return movies.map((movie) => Movie.fromJson(movie)).toList();
  }

  factory MoviePaginator.fromJson(Map<String, dynamic> json) => _$MoviePaginatorFromJson(json);
  Map<String, dynamic> toJson() => _$MoviePaginatorToJson(this);

  bool get hasNextPage => page++ <= totalPages;

}
