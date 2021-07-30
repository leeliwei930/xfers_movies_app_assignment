// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_paginator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviePaginator _$MoviePaginatorFromJson(Map<String, dynamic> json) {
  return MoviePaginator(
    page: json['page'] as int,
    results: MoviePaginator._parseMovieList(json['results'] as List),
    totalPages: json['total_pages'] as int,
    totalResults: json['total_results'] as int,
  );
}

Map<String, dynamic> _$MoviePaginatorToJson(MoviePaginator instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
      'total_results': instance.totalResults,
    };
