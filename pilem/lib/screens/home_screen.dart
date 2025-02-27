import 'package:flutter/material.dart';
import 'package:pilem/models/movie.dart';
import 'package:pilem/screens/detail_screen.dart';
import 'package:pilem/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();
  List<Movie> _allMovies = [];
  List<Movie> _trendingMovies = [];
  List<Movie> _popularMovies = [];

  Future<void> _loadMovies() async {
    final movies = await _apiServices.getAllMovies();
    final trending = await _apiServices.getTrendingMovies();
    final popular = await _apiServices.getPopularMovies();

    setState(() {
      _allMovies = movies;
      _trendingMovies = trending;
      _popularMovies = popular;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilem')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMoviesList("All Movies", _allMovies),
            _buildMoviesList("Trending Movies", _trendingMovies),
            _buildMoviesList("Popular Movies", _popularMovies),
          ],
        ),
      ),
    );
  }

  Widget _buildMoviesList(String title, List<Movie> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (BuildContext context, int index) {
              final Movie movie = movies[index];
              return GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(movie: movie),
                      ),
                    ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                        width: 120,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 5),
                      Text(
                        movie.title.length > 14
                            ? '${movie.title.substring(0, 10)}...'
                            : movie.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
