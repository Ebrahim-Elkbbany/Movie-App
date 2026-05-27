import 'package:equatable/equatable.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';

class MovieCategoryModel extends Equatable {
  final String title;
  final List<MovieModel> movies;

  const MovieCategoryModel({required this.title, required this.movies});

  @override
  List<Object?> get props => [title, movies];
}
