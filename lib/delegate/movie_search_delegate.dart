
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xfers_movie_assignment/components/tag_chip.dart';
import 'package:xfers_movie_assignment/constants/text_styles.dart';
import 'package:xfers_movie_assignment/controllers/movie_controller.dart';
import 'package:xfers_movie_assignment/models/movie.dart';
class MovieSearchDelegate<T> extends SearchDelegate {

  late String initialQuery;
   MovieController _controller = Get.find<MovieController>();

  MovieSearchDelegate({this.initialQuery = ""}){
    this.query = initialQuery;
  }


  @override
  void showResults(BuildContext context) async {
    if(query.length > 0){
      await this._controller.searchMovie(keyword: query, clearPreviousResult: true);
    }
    super.showResults(context);
  }

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Search Movies";

  @override
  Widget buildSuggestions(BuildContext context) {
    return Obx((){
      late List<Movie> suggestedMovies = <Movie>[];
      if(this.query.length <= 0){
        suggestedMovies = _controller.trendingMovies.sublist(0, 5);
      } else {
        _controller.searchMovie(keyword: query, clearPreviousResult: true);
        suggestedMovies = _controller.movieResults();
      }
      return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Movie movie = suggestedMovies.elementAt(index);
          return ListTile(
            onTap: () async {
              this.query = movie.originalTitle;
              await this._controller.searchMovie(keyword: query, clearPreviousResult: true);
              close(context, this.query);
            },
            leading: Icon(Icons.north_west),
            title: Text(movie.originalTitle),
          );
        },
        itemCount: suggestedMovies.length,
      );
    });
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: (){
            this.query = "";
          },
          icon: Icon(Icons.clear)

      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => closeSearch(context)
    );
  }

  @override
  Widget buildResults(BuildContext context)  {
    print("build");

    return Obx((){
      List<Movie> results = _controller.movieResults();
      return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Movie movie = results.elementAt(index);
          return ListTile(

              onTap: () async {
                this.query = movie.originalTitle;
                await this._controller.searchMovie(keyword: query, clearPreviousResult: true);
                close(context, this.query);
              },
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 32, ),
                  Text(movie.voteAverage.toString(),
                      style: kRatingTextStyle.copyWith(fontSize: 16))
                ],
              ),
              title: Text(movie.originalTitle),
              subtitle:  Text(movie.formatReleaseDate()),
              trailing: Icon(Icons.chevron_right)

          );
        },
        itemCount: results.length,
      );
    });
  }
  @override
  set query(String value)  {
    // TODO: implement query
    super.query = value;
  }
  void closeSearch(BuildContext context){
    close(context, this.query);
  }

}
