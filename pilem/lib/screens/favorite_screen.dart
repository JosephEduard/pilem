import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Movie> _favoriteMovies = [];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black87,
        appBarTheme: AppBarTheme(backgroundColor: Colors.black45, elevation: 0),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white70),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text("Favorite"), centerTitle: true),
        body: ListView.builder(
          itemCount: _favoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = _favoriteMovies[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListTile(
                leading: Image.network(
                  movie.posterPath != ''
                      ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                      : 'https://placehold.co/50x75?text=No+Image',
                  width: 50,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(movie.title),
                ),
                onTap: () {
                  Navigator.push<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (context) => DetailScreen(movie: movie),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
