import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;
  final int year;

  const MovieModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.year,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      year: (json['year'] ?? 0) ,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        imageUrl,
        rating,
      ];
}