import 'package:flutter/material.dart';
import 'package:xfers_movie_assignment/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie? movie;
  final bool isLoading;
  MovieCard({this.movie, this.isLoading = false});
  @override
  Widget build(BuildContext context) {

    // show the loading placeholder image
    if(isLoading){
      return buildMovieCardLoader(context);
    }
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(movie!.getPosterImageUrl(size: "w185")),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(movie!.originalTitle),
                  Text(movie!.releaseDate.year.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMovieCardLoader(BuildContext context){
    return Card(

    );
  }
}
