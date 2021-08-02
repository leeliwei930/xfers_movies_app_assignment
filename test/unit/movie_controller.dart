import 'package:get/get_connect.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:xfers_movie_assignment/controllers/movie_controller.dart';
import 'package:xfers_movie_assignment/providers/moviedb_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'movie_controller.mocks.dart';

@GenerateMocks([MoviedbProvider])
void main() {
  MockMoviedbProvider mockedProvider = MockMoviedbProvider();

  when(mockedProvider.trending(page: 1)).thenAnswer((_) async {
    return buildMockResponse();
  });
  when(mockedProvider.search(query: "Jobs" , page: 1)).thenAnswer((_) async {
    return buildMockResponse(filter: "Jobs");
  });
  when(mockedProvider.onInit()).thenAnswer((_)  {
    return mockedProvider;
  });
  group("movie controller tests", (){
    test("able to load trending movies", () async {

      MovieController controller = MovieController()..onInit(provider: mockedProvider);

      await controller.loadTrendingMovies(forceRefresh: true);
      expect(controller.trendingMovies.length, equals(7));

    });

    test("able to search movies", () async {

      MovieController controller = MovieController()..onInit(provider: mockedProvider);

      await controller.searchMovie(keyword: "Jobs");
      expect(controller.movieResults.length, equals(2));
    });
  });
}

Response buildMockResponse({filter: ""}){
  // total 7 movies, 5 superman movies and 2 Jobs biography
  List<Map<String, dynamic>> results = [
    {
      "adult": false,
      "backdrop_path": "/A2KqRrQ0cVCFEl7Qf0YttMa3QkS.jpg",
      "genre_ids": [
        28,
        16,
        878,
        10751
      ],
      "id": 13640,
      "original_language": "en",
      "original_title": "Superman: Doomsday",
      "overview": "When LexCorp accidentally unleashes a murderous creature, Superman meets his greatest challenge as a champion. Based on the \"The Death of Superman\" storyline that appeared in DC Comics' publications in the 1990s.",
      "popularity": 78.023,
      "poster_path": "/itvuWm7DFWWzWgW0xgiaKzzWszP.jpg",
      "release_date": "2007-09-18",
      "title": "Superman: Doomsday",
      "video": false,
      "vote_average": 6.7,
      "vote_count": 415
    },
    {
      "adult": false,
      "backdrop_path": "/v6MVBFnQOscITvmAy5N5ras2JKZ.jpg",
      "genre_ids": [
        878,
        28,
        12
      ],
      "id": 1924,
      "original_language": "en",
      "original_title": "Superman",
      "overview": "Mild-mannered Clark Kent works as a reporter at the Daily Planet alongside his crush, Lois Lane. Clark must summon his superhero alter-ego when the nefarious Lex Luthor launches a plan to take over the world.",
      "popularity": 27.372,
      "poster_path": "/d7px1FQxW4tngdACVRsCSaZq0Xl.jpg",
      "release_date": "1978-12-13",
      "title": "Superman",
      "video": false,
      "vote_average": 7.1,
      "vote_count": 2735
    },
    {
      "adult": false,
      "backdrop_path": "/bazlsLkNuhy3IuhviepqvlMm2hV.jpg",
      "genre_ids": [
        16,
        28,
        878
      ],
      "id": 618354,
      "original_language": "en",
      "original_title": "Superman: Man of Tomorrow",
      "overview": "It’s the dawn of a new age of heroes, and Metropolis has just met its first. But as Daily Planet intern Clark Kent – working alongside reporter Lois Lane – secretly wields his alien powers of flight, super-strength and x-ray vision in the battle for good, there’s even greater trouble on the horizon.",
      "popularity": 50.69,
      "poster_path": "/6Bbq8qQWpoApLZYWFFAuZ1r2gFw.jpg",
      "release_date": "2020-08-23",
      "title": "Superman: Man of Tomorrow",
      "video": false,
      "vote_average": 7.4,
      "vote_count": 259
    },
    {
      "adult": false,
      "backdrop_path": "/3KAZQXUJn1MG8QTIfzgHrZcpF4V.jpg",
      "genre_ids": [
        878,
        28,
        12
      ],
      "id": 8536,
      "original_language": "en",
      "original_title": "Superman II",
      "overview": "Three escaped criminals from the planet Krypton test the Man of Steel's mettle. Led by General Zod, the Kryptonians take control of the White House and partner with Lex Luthor to destroy Superman and rule the world. But Superman, who attempts to make himself human in order to get closer to Lois, realizes he has a responsibility to save the planet.",
      "popularity": 22,
      "poster_path": "/jw0tYFCbzjBN8SIhvRC2kdh7pzh.jpg",
      "release_date": "1980-12-04",
      "title": "Superman II",
      "video": false,
      "vote_average": 6.7,
      "vote_count": 1628
    },
    {
      "adult": false,
      "backdrop_path": "/rGgqwztE7v3jX3e7zWAIRy74vlH.jpg",
      "genre_ids": [
        878,
        16,
        28,
        12,
        10751
      ],
      "id": 22855,
      "original_language": "en",
      "original_title": "Superman/Batman: Public Enemies",
      "overview": "United States President Lex Luthor uses the oncoming trajectory of a Kryptonite meteor to frame Superman and declare a \$1 billion bounty on the heads of the Man of Steel and his ‘partner in crime’, Batman. Heroes and villains alike launch a relentless pursuit of Superman and Batman, who must unite—and recruit help—to try and stave off the action-packed onslaught, stop the meteor Luthors plot.",
      "popularity": 40.072,
      "poster_path": "/izvMc22ywSLFWUXZEIuJJ8dms75.jpg",
      "release_date": "2009-09-29",
      "title": "Superman/Batman: Public Enemies",
      "video": false,
      "vote_average": 7,
      "vote_count": 425
    },
    {
      "adult": false,
      "backdrop_path": "/uwrDci0vra94RNeqjRWOEICWtxj.jpg",
      "genre_ids": [
        18,
        36
      ],
      "id": 115782,
      "original_language": "en",
      "original_title": "Jobs",
      "overview": "The story of Steve Jobs' ascension from college dropout into one of the most revered creative entrepreneurs of the 20th century.",
      "popularity": 10.874,
      "poster_path": "/mOyZ0UAWaOJartFq2G3Cv0soFtQ.jpg",
      "release_date": "2013-08-16",
      "title": "Jobs",
      "video": false,
      "vote_average": 6.1,
      "vote_count": 2000
    },
    {
      "adult": false,
      "backdrop_path": "/bBgoMzo2fXpZYYNlJuG5WAW5wzA.jpg",
      "genre_ids": [
        18,
        36
      ],
      "id": 321697,
      "original_language": "en",
      "original_title": "Steve Jobs",
      "overview": "Set backstage at three iconic product launches and ending in 1998 with the unveiling of the iMac, Steve Jobs takes us behind the scenes of the digital revolution to paint an intimate portrait of the brilliant man at its epicenter.",
      "popularity": 14.072,
      "poster_path": "/92vhEJ6xWoDJ8UHECAJaRofaSCZ.jpg",
      "release_date": "2015-10-09",
      "title": "Steve Jobs",
      "video": false,
      "vote_average": 6.8,
      "vote_count": 3377
    },
  ];
  if(filter.length > 0){
    results = results.where((element) => element['title'].contains(filter)).toList();
  }
  return Response(
      statusCode: 200,
      body: {
        "page": 1,
        "results": results,
        "total_pages": 1,
        "total_results": results.length
      }
  );
}
