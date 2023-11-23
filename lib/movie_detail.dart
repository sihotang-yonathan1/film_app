import 'dart:convert';

import 'package:film_app/util/network.dart';

class MovieDetailGenre {
  final int id;
  final String name;

  MovieDetailGenre({
    required this.id,
    required this.name,
  });

  factory MovieDetailGenre.fromJson(Map<String, dynamic> jsonData) {
    return MovieDetailGenre(id: jsonData['id'], name: jsonData['name']);
  }
}

class MovieDetail {
  final String title;
  final String description;
  final String posterPath;
  final String backdropImagePath;
  final String originalTitle;
  final DateTime releaseDate;
  final double averageVote;
  final List<MovieDetailGenre> genres;
  final int movieDuration;

  MovieDetail(
      {required this.title,
      required this.description,
      required this.posterPath,
      required this.backdropImagePath,
      required this.originalTitle,
      required this.releaseDate,
      required this.averageVote,
      required this.genres,
      required this.movieDuration});

  factory MovieDetail.fromJson(Map<String, dynamic> jsonData) {
    // Maybe need more 'elegant' solutions
    final List<MovieDetailGenre> movieGenres = [];
    for (var genre in jsonData['genres']) {
      movieGenres.add(MovieDetailGenre.fromJson(genre));
    }
    return MovieDetail(
        title: jsonData['title'],
        description: jsonData['overview'],
        posterPath: jsonData['poster_path'],
        backdropImagePath: jsonData['backdrop_path'],
        originalTitle: jsonData['original_title'],
        releaseDate: DateTime.parse(jsonData['release_date']),
        averageVote: jsonData['vote_average'],
        genres: movieGenres,
        movieDuration: jsonData['runtime']);
  }
}

Future<MovieDetail> fetchMovieDetail(int movieId) async {
  // final response = await http.get(Uri.parse(
  //     'https://api.themoviedb.org/3/movie/${movieId}?api_key=${API_KEY}'));
  final response = await fetchApiCall('/movie/${movieId}');
  if (response.statusCode == 200) {
    return MovieDetail.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    // TODO: use logging instead of print statement
    print(response.statusCode);
    print(response.body);

    throw Exception('Error when fetching movie detail');
  }
}
