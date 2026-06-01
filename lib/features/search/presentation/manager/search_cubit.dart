import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/search/data/repos/search_repo.dart';
import 'package:movie_app/features/search/presentation/manager/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo searchRepo;
  SearchCubit(this.searchRepo) : super(SearchInitial()) {
    scrollController.addListener(_onScroll);
  }
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  void _onScroll() {
    if (isLoading) return;

    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    searchController.dispose();
    return super.close();
  }

  List<MovieModel> movies = [];
  String query = '';
  int page = 1;

  bool hasMore = false;
  bool isLoading = false;
  Future<void> searchMovies(String newQuery) async {
    if (newQuery.trim().isEmpty) {
      emit(SearchLoading());
      query = '';
      page = 1;
      movies.clear();
      hasMore = false;
      emit(SearchInitial());
      return;
    }
    emit(SearchLoading());
    query = newQuery;
    page = 1;
    movies.clear();
    hasMore = true;
    final result = await searchRepo.searchMovies(page: page, query: query);

    return result.fold(
      (erorr) {
        emit(SearchError(erorr.errorMessage));
      },
      (response) {
        movies.addAll(response.movies);
        hasMore = movies.length < response.movieCount;
        emit(SearchSuccess(movies: movies, hasMore: hasMore));
        page++;
      },
    );
  }

  Future<void> loadMore() async {
    if (isLoading || !hasMore) return;

    isLoading = true;
    emit(SearchPaginationLoading(movies));

    final result = await searchRepo.searchMovies(page: page, query: query);
    result.fold(
      (erorr) {
        isLoading = false;
        emit(SearchError(erorr.toString()));
      },
      (response) {
        movies.addAll(response.movies);

        hasMore = movies.length < response.movieCount;

        emit(SearchSuccess(movies: movies, hasMore: hasMore));

        page++;

        isLoading = false;
      },
    );
  }
}
