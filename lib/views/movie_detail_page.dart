
import 'package:flutter/material.dart';
import 'package:xfers_movie_assignment/components/readable_field.dart';
import 'package:xfers_movie_assignment/components/tag_chip.dart';
import 'package:xfers_movie_assignment/constants/language_local.dart';
import 'package:xfers_movie_assignment/models/movie.dart';
import 'package:xfers_movie_assignment/constants/text_styles.dart';
import 'package:get/get.dart';
class MovieDetailPage extends StatefulWidget {
  final Movie movie;
  _MovieDetailPageState createState() => _MovieDetailPageState();
  MovieDetailPage({required this.movie});
}

class _MovieDetailPageState extends State<MovieDetailPage> {

  late Movie movie;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.movie = widget.movie;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("movie_detail".tr),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          IntrinsicHeight(
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Builder(
                  builder: (BuildContext context){
                    if(movie.getPosterImageUrl(size: "w185") != null){
                      return Hero(
                        tag: "${movie.originalTitle}-poster",
                        child: Image.network(
                          movie.getPosterImageUrl(size: "w185")!,
                          loadingBuilder: (BuildContext context, Widget widget, ImageChunkEvent? event){
                            if(event == null) return widget;
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              color: Colors.grey,
                            );
                          },
                          errorBuilder: (BuildContext context, error, stackTrace){
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.25,
                              width: 125,
                              color: Colors.grey,
                            );
                          },
                        ),
                      );
                    }
                    return Container(
                      width: 125,
                      decoration: BoxDecoration(
                          color: Colors.grey
                      ),
                      child: Center(
                        child: Icon(Icons.local_movies, size: 36, color: Colors.white,),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        movie.originalTitle,
                        style: kCardTitleTextStyle,
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    SizedBox(width: 15,),
                    if(movie.adult)
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
                    child:Text(movie.formatReleaseDate(),
                      style: kCardSubtitleTextStyle.copyWith(color: Theme.of(context).primaryColor),),
                    outlineColor: Theme.of(context).primaryColor
                ),
                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 24, ),
                    Text(movie.formatVoteAverage(),
                        style: kRatingTextStyle)
                  ],
                )
              ],
            ),
          ),
          ReadableField(
            label: "overview".tr,
            value: movie.overview,
          ),
          ReadableField(
            label: "vote_count".tr,
            value: movie.formatVoteCount(),
            valueTextStyle: kReadableFieldNumericValueTextStyle.copyWith(color: Theme.of(context).accentColor),
          ),
          ReadableField(
            label: "vote_average".tr,
            value: movie.formatVoteAverage(),
            valueTextStyle: kReadableFieldNumericValueTextStyle.copyWith(color: Theme.of(context).accentColor),

          ),
          ReadableField(
            label: "popularity".tr,
            value: movie.formatPopularity(),
            valueTextStyle: kReadableFieldNumericValueTextStyle.copyWith(color: Theme.of(context).accentColor),

          ),
          ReadableField(
            label: "language".tr,
            value: LanguageLocal().getDisplayLanguage(movie.originalLanguage) ?? movie.originalLanguage,
            valueTextStyle: kReadableFieldNumericValueTextStyle.copyWith(color: Theme.of(context).accentColor),

          )

        ],
      ),
    );
  }
}
