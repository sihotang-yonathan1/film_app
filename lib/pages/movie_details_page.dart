import 'package:film_app/movie_detail.dart';
import 'package:flutter/material.dart';

// TODO: test this method in unit test
String getTimeString(int value) {
  final int hour = value ~/ 60;
  final int minutes = value % 60;
  return '${hour.toString()} h ${minutes.toString()} m';
}

class MovieDetailspage extends StatefulWidget {
  int movieId;

  MovieDetailspage({super.key, required this.movieId});

  @override
  State<MovieDetailspage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailspage> {
  late Future<MovieDetail> futureMovieDetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMovieDetail = fetchMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Details'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        // TODO: simplify body widget
        body: FutureBuilder(
          future: futureMovieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              return SafeArea(
                  child: ListView(
                children: [
                  Center(
                      child:
                          Stack(alignment: Alignment.center, children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.black54,
                            child: Opacity(
                              opacity: 0.1,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original${snapshot.data!.posterPath}',
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ]),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original${snapshot.data!.posterPath}',
                                width: 300,
                                height: 300,
                              ),
                            ),
                            Column(children: [
                              Text(
                                '${snapshot.data!.title} (${snapshot.data!.releaseDate.year})',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35,
                                    color: Colors.white),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              Text(
                                                snapshot.data!.averageVote
                                                    .toStringAsFixed(1),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ])),
                                        Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(children: [
                                              const Icon(
                                                Icons.access_time,
                                                color: Colors.white60,
                                              ),
                                              Text(
                                                  getTimeString(snapshot
                                                      .data!.movieDuration),
                                                  style: const TextStyle(
                                                      color: Colors.white))
                                            ]))
                                      ])),
                            ])
                          ]),
                        ],
                      ),
                    ),
                  ])),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        const Text(
                          'Overview',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(snapshot.data!.description)),
                        // Text(widget.movieId.toString())
                      ],
                    ),
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              print('Error in async/await: FutureBuilder - MovieDetails');
              print(snapshot.error.toString());
              return const CircularProgressIndicator();
            } else {
              print("Processing");
              return const CircularProgressIndicator();
            }
          },
        ));
    //
  }
}

// ListView(children: [
//     Container(
//       child: Text('Image Here'),
//     ),
//     Container(
//       child: Column(
//         children: [Text('Title here')],
//       ),
//     ),
//     Container(
//       child: Column(
//         children: [Text('Overview'), Text('Description Here')],
//       ),
//     )
//   ]),
// );
