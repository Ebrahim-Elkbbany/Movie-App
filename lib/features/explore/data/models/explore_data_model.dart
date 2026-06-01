import 'explore_movie_model.dart';

class ExploreDataModel {
  int? movieCount;
  int? limit;
  int? pageNumber;
  List<ExploreMovieModel>? movies;

  ExploreDataModel({this.movieCount, this.limit, this.pageNumber, this.movies});

  ExploreDataModel.fromJson(Map<String, dynamic> json) {
    movieCount = json['movie_count'];
    limit = json['limit'];
    pageNumber = json['page_number'];
    if (json['movies'] != null) {
      movies = <ExploreMovieModel>[];
      json['movies'].forEach((v) {
        movies!.add(ExploreMovieModel.fromJson(v));
      });
    }
  }
}
