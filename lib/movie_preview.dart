import 'dart:convert';

import 'package:film_app/util/network.dart';

// MoviePreview Object

class MoviePopularResult {
  final bool? isAdult;
  final int id;
  final String title;
  final String posterPath;
  final num voteAverage;

  const MoviePopularResult(
      {required this.isAdult,
      required this.id,
      required this.title,
      required this.posterPath,
      required this.voteAverage});

  factory MoviePopularResult.fromJson(Map<String, dynamic> json) {
    // print(json);
    return MoviePopularResult(
        isAdult: json['adult'],
        id: json['id'],
        title: json['title'] ?? json['name'],
        posterPath: json['poster_path'],
        voteAverage: json['vote_average']);
  }
}

class MoviePopularPage {
  final int pageNum;
  final List<MoviePopularResult> results;

  const MoviePopularPage({required this.pageNum, required this.results});

  factory MoviePopularPage.fromJson(Map<String, dynamic> jsonData) {
    List<MoviePopularResult> results = [];
    // print('jsonData: $jsonData');

    // TODO: handling empty result
    for (var singleResult in jsonData['results']) {
      results.add(MoviePopularResult.fromJson(singleResult));
    }
    var tempData =
        MoviePopularPage(pageNum: jsonData['page'], results: results);
    return tempData;
  }
}

Future<MoviePopularPage> fetchFilmPopularPage({type = 'movie'}) async {
  final response = await fetchApiCall('/discover/$type');
  if (response.statusCode == 200) {
    // print(response.body);
    var tempData = MoviePopularPage.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
    return tempData;
  } else {
    // TODO: use logging instead of print statement
    print(response.statusCode);
    print(response.body);

    // TODO: Tell error more specific
    throw Exception("There is error when fetching API");
  }
}
