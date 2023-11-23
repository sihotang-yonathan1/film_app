import 'dart:convert';

import 'package:film_app/util/network.dart';

// MoviePreview Object

class MoviePopularResult {
  final bool? isAdult;
  final int id;
  final String title;
  final String posterPath;

  const MoviePopularResult(
      {required this.isAdult,
      required this.id,
      required this.title,
      required this.posterPath});

  factory MoviePopularResult.fromJson(Map<String, dynamic> json) {
    // print(json);
    return MoviePopularResult(
        isAdult: json['adult'],
        id: json['id'],
        title: json['title'] ?? json['name'],
        posterPath: json['poster_path']);
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
  // const String API_BASE_URL = 'https://api.themoviedb.org/3/discover/';
  // final response = await http.get(Uri.parse(
  //     '${API_BASE_URL}${type}?sort_by=popularity.desc&api_key=${API_KEY}'));
  final response = await fetchApiCall('/discover/$type');
  if (response.statusCode == 200) {
    // print(response.body);
    var temp_data = MoviePopularPage.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
    return temp_data;
  } else {
    // TODO: use logging instead of print statement
    print(response.statusCode);
    print(response.body);

    // TODO: Tell error more specific
    throw Exception("There is error when fetching API");
  }
}
