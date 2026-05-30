import 'package:equatable/equatable.dart';

class CastModel extends Equatable {
  final String name;
  final String character;
  final String image;

  CastModel({required this.name, required this.character, required this.image});

  @override
  List<Object?> get props => [name, character, image];
}

class MovieDetailModel extends Equatable {
  final String title;
  final double rating;
  final int year;
  final String description;
  final int runtime;
  final int likecount;
  final List<String> genres;
  final String backgroundImage;
  final List<CastModel> cast;
  final List<String> screenshots;

 const MovieDetailModel({
    required this.title,
    required this.rating,
    required this.year,
    required this.description,
    required this.runtime,
    required this.likecount,
    required this.genres,
    required this.backgroundImage,
    required this.cast,
    required this.screenshots,
  });
 factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
  final movie = json['data']['movie'];

  return MovieDetailModel(
    title: movie['title'] ?? '',
    rating: (movie['rating'] as num?)?.toDouble() ?? 0.0,
    year: movie['year'] ?? 0,
    runtime: movie['runtime'] ?? 0,
    likecount: movie['like_count'] ?? 0,
    genres: List<String>.from(movie['genres'] ?? []),
    backgroundImage: movie['medium_cover_image'] ?? '',
    screenshots: [
      movie['medium_screenshot_image1'],
      movie['medium_screenshot_image2'],
      movie['medium_screenshot_image3'],
    ].whereType<String>().toList(),
    cast: (movie['cast'] as List? ?? [])
        .map((e) => CastModel(
              name: e['name'] ?? '',
              character: e['character_name'] ?? '',
              image: e['url_small_image'] ?? '',
            ))
        .toList(),
    description: movie['description_full'] ?? '',
  );
  }

  @override
  List<Object?> get props => [
    title,
    rating,
    year,
    description,
    runtime,
    genres,
    backgroundImage,
    cast,
    screenshots,
    likecount,
  ];
}
