

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'dart:async';

class MoviedbProvider extends GetConnect {

  String endpoint = "https://api.themoviedb.org/";
  String apiVersion = "3";
  String? apiKey;

  MoviedbProvider({this.endpoint = "https://api.themoviedb.org/", this.apiVersion = "3", required this.apiKey}){
    if(this.apiKey == null){
      throw Exception("The MovieDB API key is required, please specify it in the .env file with MOVIE_DB_API_KEY as environment variable");
    }
  }
  @override
  void onInit() {
    // set the movied db based url
    httpClient.baseUrl = "$endpoint/$apiVersion";
    httpClient.addRequestModifier((Request request){
      request.headers['accept'] = "application/json";
      return request;
    });

    // capture http error explicitly
    httpClient.errorSafety = false;
  }

  Future<Response> search({query: "superman", page: 1}){
    return get("/search", query: {
      "api_key" : apiKey,
      "query" : query,
      "page" : page.toString()
    });
  }

  Future<Response> trending({type: "movie", scope: "week", page: 1}){
    return get("/trending/$type/$scope", query: {
      "api_key" : apiKey,
      "page" : page.toString()
    });
  }

}
