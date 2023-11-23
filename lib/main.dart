import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

Future<http.Response> fetchTestAPI() {
  return http.get(Uri.parse('https://www.fruityvice.com/api/fruit/all'));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Film App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Film App'),
        initialRoute: '/',
        routes: {
          // '/': (context) => const MyHomePage(title: 'Film App'),
          // '/details': (context) => const MovieDetailPage(
          //       title: 'Hello',
          //     )
          '/': (context) => const MovieTestPage(),
          '/details': (context) =>
              movie_detail_page.MovieDetailspage(movieId: 1),
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final dummyData = <Widget>[
      moviePreview('hello',
          'https://oyster.ignimgs.com/mediawiki/apis.ign.com/pokemon-blue-version/8/89/Pikachu.jpg?width=325'),
      moviePreview('Hello 2',
          'https://oyster.ignimgs.com/mediawiki/apis.ign.com/pokemon-blue-version/8/89/Pikachu.jpg?width=325'),
      moviePreview('Hello 2',
          'https://id.portal-pokemon.com/play/resources/pokedex/img/pm/2b3f6ff00db7a1efae21d85cfb8995eaff2da8d8.png')
    ];

    // TODO: set the page scrollable
    return Scaffold(
        appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Center(
            child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            createSection(context, 'Trending', dummyData, ''),
          ],
        )));
  }
}

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: const Text('Movie Detail')),
        body: const SafeArea(
          child: Column(
            children: [Text('Hello From page 2')],
          ),
        ));
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
                                                  Text(e.id.toString()),
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
