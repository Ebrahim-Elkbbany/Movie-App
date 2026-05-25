import 'package:equatable/equatable.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String imageUrl;
  final double rating;

  const MovieModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.rating,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrl: json['medium_cover_image'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
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