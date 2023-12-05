import 'package:flutter/material.dart';

import 'package:film_app/movie_preview.dart';
import 'package:film_app/pages/movie_details_page.dart' as movie_detail_page;
import 'package:film_app/pages/about_page.dart';

void main() {
  runApp(const MyApp());
}

Widget moviePreview(String title, String imageurl) {
  return (Column(children: [
    Image.network(
      imageurl,
      width: 300,
      height: 300,
    ),
    Text(title),
    ElevatedButton(
        // TODO: set button to navigate between page
        onPressed: () => print('Hello WOrld'),
        child: const Text('Details'))
  ]));
}

Widget createSection(
    BuildContext ctx, String title, List<dynamic> dataList, String sectionUri) {
  return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              title.toString(),
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            IconButton(
                onPressed: () => Navigator.of(ctx),
                icon: const Icon(Icons.arrow_forward))
          ]),
          SizedBox(
            height: 300,
            child: ListView(
                scrollDirection: Axis.horizontal, children: [...dataList]),
          )
        ],
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Film App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MovieTestPage(),
          '/details': (context) =>
              movie_detail_page.MovieDetailspage(movieId: 1),
        });
  }
}

class MovieTestPage extends StatefulWidget {
  const MovieTestPage({super.key});

  @override
  State<MovieTestPage> createState() => _MovieTestPageState();
}

class _MovieTestPageState extends State<MovieTestPage> {
  late Future<MoviePopularPage> futureMoviePage;
  late Future<MoviePopularPage> futureTVPage;
  List<MoviePopularResult> movieResult = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureMoviePage = fetchFilmPopularPage(type: 'movie');
    futureTVPage = fetchFilmPopularPage(type: 'tv');
  }

  void setMovieResult(List<MoviePopularResult> movieResults) {
    setState(() {
      movieResult = movieResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: investigate why the resultData is not changed
    // List<MoviePopularResult> resultData = [];

    return Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
            'FilmApp',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500),
          )),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const AboutPage(),
                        )),
                    icon: const Icon(Icons.info_outline)))
          ],
        ),
        body: Column(children: [
          FutureBuilder(
              future: futureMoviePage,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // print(snapshot.data);
                  print(snapshot.data!.results);
                  return Expanded(
                      child: ListView(children: [
                    Material(
                        child: createSection(
                            context,
                            'Popular (Movies)',
                            snapshot.data!.results
                                .map((e) => Material(
                                    child: Material(
                                        child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                        vertical: 15),
                                                child: Column(children: [
                                                  Image.network(
                                                    'https://image.tmdb.org/t/p/original${e.posterPath}',
                                                    width: 200,
                                                    height: 200,
                                                  ),
                                                  FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        e.title,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                  Row(children: [
                                                    Icon(Icons.star,
                                                        color: Colors.amber),
                                                    Text(e.voteAverage
                                                        .toString())
                                                  ]),
                                                  ElevatedButton(
                                                      onPressed: () =>
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    movie_detail_page.MovieDetailspage(
                                                                        movieId:
                                                                            e.id),
                                                              )),
                                                      child:
                                                          const Text('Details'))
                                                ]))))))
                                .toList(),
                            '')),
                  ]));
                } else {
                  print('Error in async/await: FutureBuilder - Main');
                  print(snapshot.error.toString());
                  return const CircularProgressIndicator();
                }
              }),
        ]));
  }
}
