import 'package:flutter/material.dart';
import 'package:xfers_movie_assignment/components/tag_chip.dart';
import 'package:xfers_movie_assignment/constants/text_styles.dart';
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
            Image.network(
              movie!.getPosterImageUrl(size: "w185"),
              loadingBuilder: (BuildContext context, Widget widget, ImageChunkEvent? event){
                if(event == null) return widget;
                return Container(
                  width: 185,
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: Colors.grey,
                );
              },
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie!.originalTitle,
                            style: kCardTitleTextStyle,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        SizedBox(width: 15,),
                        if(movie!.adult)
                          TagChip(
                            child:Text("M",
                              style: kCardSubtitleTextStyle.copyWith(color: Colors.white),),
                            backgroundColor: Theme.of(context).colorScheme.error,
                            outlineColor: Theme.of(context).colorScheme.error,

                          ),
                      ],
                    ),
                    SizedBox(height: 5,),
                    TagChip(
                        child:Text(movie!.formatReleaseDate(),
                          style: kCardSubtitleTextStyle.copyWith(color: Theme.of(context).primaryColor),),
                        outlineColor: Theme.of(context).primaryColor
                    ),
                    SizedBox(height: 15,),
                    Text(movie!.overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 32, ),
                        Text(movie!.voteAverage.toString(),
                            style: kRatingTextStyle)
                      ],
                    )
                  ],
                ),
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
