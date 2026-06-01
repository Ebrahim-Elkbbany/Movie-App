import 'package:movie_app/features/home/data/models/movie_model.dart';

class MoviesResponse {
  final int movieCount;
  final int limit;
  final int pageNumber;
  final List<MovieModel> movies;

  MoviesResponse({
    required this.movieCount,
    required this.limit,
    required this.pageNumber,
    required this.movies,
  });

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return MoviesResponse(
      movieCount: data['movie_count'] ?? 0,
      limit: data['limit'] ?? 20,
      pageNumber: data['page_number'] ?? 1,
      movies: (data['movies'] as List? ?? [])
          .map((e) => MovieModel.fromJson(e))
          .toList(),
    );
  }
}
