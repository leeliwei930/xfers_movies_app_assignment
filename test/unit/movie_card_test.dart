import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xfers_movie_assignment/components/movie_card.dart';
import 'package:xfers_movie_assignment/models/movie.dart';

void main(){
  testWidgets("Movie card onTap", (WidgetTester tester) async {
    Movie movie = Movie(
        adult: true,
        id: 1000,
        originalTitle: "Steve Jobs",
        originalLanguage: "en",
        popularity: 1000,
        overview: "A documentary biography of Steve Jobs",
        title: "Steve Jobs",
        video: false,
        voteCount: 1000,
        voteAverage: 8.2,
        releaseDate: DateTime.parse("2018-02-01"),
        genresId: [1,2,3],
        posterPath: ''
    );
    bool onTapCalled = false;
    MovieCard movieCard = MovieCard(
      movie: movie,
      onTap: (){
        onTapCalled = true;
      },
    );
    await tester.pumpWidget(
      MaterialApp(
        home: movieCard
      )
    );

    expect(find.text(movie.originalTitle), findsOneWidget);
    expect(find.text(movie.voteAverage.toString()), findsOneWidget);
    await tester.tap(find.byType(InkWell));
    expect(onTapCalled, true);
  });
}
