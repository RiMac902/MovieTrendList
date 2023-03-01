import 'package:flutter/material.dart';
import 'package:movie_list/description.dart';
import 'package:movie_list/custom_text.dart';

import 'fetch.dart';

const String baseUrl = 'https://image.tmdb.org/t/p/w500';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoading = false;
  int _currentPage = 1;
  final List<dynamic> _movies = [];

  @override
  void initState() {
    _fetchMovies();
    super.initState();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });
    try {
      final List<dynamic> movies = await fetchMovies(_currentPage);
      setState(() {
        _movies.addAll(movies);
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Movie List'),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _movies.length + 1,
                itemBuilder: (context, index) {
                  if (index == _movies.length) {
                    return Center(
                      child: ElevatedButton(
                        onPressed: _fetchMovies,
                        child: const Text('Load More'),
                      ),
                    );
                  } else {
                    final movie = _movies[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Description(
                              title: movie['title'],
                              overview: movie['overview'],
                              voteAverage: movie['vote_average'],
                              releaseDate: movie['release_date'],
                              posterPath: '$baseUrl${movie['poster_path']}',
                              backdropPath: '$baseUrl${movie['backdrop_path']}',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.2)),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2)),
                              ]),
                          clipBehavior: Clip.hardEdge,
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    '$baseUrl${movie['poster_path']}',
                                    height: 150,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 20),
                                        CustomText(
                                          text: movie['title'],
                                          fontWeight: FontWeight.bold,
                                        ),
                                        const SizedBox(height: 4),
                                        CustomText(
                                          text: movie['release_date'],
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(height: 10),
                                        CustomText(
                                          text: movie['overview'],
                                          textOverflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                }),
      ),
    );
  }
}
