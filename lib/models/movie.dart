import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {

  @JsonKey(name: "adult")
  late bool adult;

  @JsonKey(name: "backdrop_path")
  late String? backdropPath;

  @JsonKey(name: "poster_path")
  late String? posterPath;

  @JsonKey(name: "genre_ids")
  late List<int> genresId;

  @JsonKey(name: "id")
  late int id;

  @JsonKey(name: "original_language")
  late String originalLanguage;

  @JsonKey(name: "original_title")
  late String originalTitle;

  @JsonKey(name: "overview")
  late String overview;

  @JsonKey(name: "popularity")
  late double popularity;

  @JsonKey(name: "release_date",fromJson: _parseDateTime)
  late DateTime? releaseDate;

  @JsonKey(name: "title")
  late String title;

  @JsonKey(name: "video")
  late bool video;

  @JsonKey(name: "vote_average")
  late double voteAverage;

  @JsonKey(name: "vote_count")
  late int voteCount;

  Movie({
    required this.adult, required this.genresId,
    required this.id, required this.originalLanguage, required this.originalTitle,
    required this.overview, required this.popularity, required this.posterPath,
    required this.releaseDate, required this.title, required this.video,
    required this.voteAverage, required this.voteCount
  });

  static DateTime? _parseDateTime(String? val){
    if(val != null ){
      return DateTime.tryParse(val);
    }
    return null;
  }

  // size available for w92, w185, w500
  String? getPosterImageUrl({size : "w92" }){
    if(this.posterPath != null){

      return "https://image.tmdb.org/t/p/$size${this.posterPath}";
    }
    return null;
  }

  String formatReleaseDate(){
    if(this.releaseDate == null){
      return "Unknown";
    }
    return DateFormat("d MMMM y").format(this.releaseDate!).toString();
  }

  String formatPopularity(){
    return NumberFormat.decimalPattern().format(this.popularity);
  }
  String formatVoteCount(){
    return NumberFormat.decimalPattern().format(this.voteCount);
  }

  String formatVoteAverage(){
    return NumberFormat.decimalPattern().format(this.voteAverage);
  }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
