
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xfers_movie_assignment/components/card_message.dart';
import 'package:xfers_movie_assignment/components/tag_chip.dart';
import 'package:xfers_movie_assignment/constants/text_styles.dart';
import 'package:xfers_movie_assignment/controllers/movie_controller.dart';
import 'package:xfers_movie_assignment/models/error.dart';
import 'package:xfers_movie_assignment/models/movie.dart';
class MovieSearchDelegate<T> extends SearchDelegate {

   MovieController _controller = Get.find<MovieController>();




  @override

  String? get searchFieldLabel => "search_movies".tr;

  @override
  Widget buildSuggestions(BuildContext context) {
    late List<Movie> suggestedMovies = <Movie>[];
    // don't perform search on empty string
    if(this.query.length <= 0){
      if(_controller.trendingMovies.length >= 5){
        suggestedMovies = _controller.trendingMovies.sublist(0, 5);
      }
    } else {
      _controller.searchMovie(keyword: query, clearPreviousResult: true);
    }
    return Obx((){
      suggestedMovies = _controller.movieResults();
      // showing loading indicator while perform searching
      if(_controller.searchSuggestionLoading()){
        return LinearProgressIndicator();
      }
      // if any error occurred, show the card error message
      if(_controller.searchError() != null){
        Error error = _controller.searchError()!;
        return Center(
          child: CardMessage(
            icon: Icon(error.icon, size: 48, color: Colors.amber,),
            message: error.message.tr,
          ),
        );
      }


      return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Movie movie = suggestedMovies.elementAt(index);
          return ListTile(
            onTap: () async {
              this.query = movie.originalTitle;
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
            // reset the query
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
      onPressed: () => closeSearch(context, "")
    );
  }

  @override
  Widget buildResults(BuildContext context)  {

    return Obx((){
      List<Movie> results = _controller.movieResults();
      // show loading indicator while performing searching
      if(_controller.searchSuggestionLoading()){
        return LinearProgressIndicator();
      }
      // show card error message when error occurred
      if(_controller.searchError() != null){
        Error error = _controller.searchError()!;
        return Center(
          child: CardMessage(
            icon: Icon(error.icon, size: 48, color: Colors.amber,),
            message: error.message.tr,
          ),
        );
      }
      return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          Movie movie = results.elementAt(index);
          return ListTile(
              onTap: () async {
                this.query = movie.originalTitle;
                await this._controller.searchMovie(keyword: query, clearPreviousResult: true);
                // close the search with return the query back to parent with future value
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


  void closeSearch(BuildContext context, String query){
    close(context, query);
  }

}
