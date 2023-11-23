import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: const Text(
          'About',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        )),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          const Text('FilmApp'),
          const Text('Developer: Group 1'),
          Container(
            margin: EdgeInsets.all(8),
            child: Column(
              children: [
                const Text(
                  'Film Data',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
                FittedBox(
                    fit: BoxFit.contain,
                    child: Row(
                      children: [
                        Image.asset('assets/tmdb_logo_attribution.png'),
                        const Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('This app\'s supplied data from TMDB API'),
                                Text(
                                    'FilmApp uses the TMDb API but is not endorsed or certified by TMDb.')
                              ],
                            ))
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
