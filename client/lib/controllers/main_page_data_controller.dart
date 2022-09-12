import 'package:client/models/main_page_data.dart';
import 'package:client/models/movie_model.dart';
import 'package:client/models/search_category.dart';
import 'package:client/services/movie_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.initial()) {
    getMovies();
  }

  final MovieService _moviesService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      List<MovieModel> _movies = [];
      if (state.searchText.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          _movies = await _moviesService.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upcoming) {
          _movies = await _moviesService.getUpcomingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.none) {
          _movies = [];
        } else {
          // Perform Text Search
          print("Inside ");
          _movies = await _moviesService.searchMovies(state.searchText,
              page: state.page);
        }
      }
      state = state.copyWith(
          movies: [...state.movies, ..._movies], page: state.page + 1);
    } catch (e) {
      print(e);
    }
  }

  void updateSearchCategory(String _category) {
    try {
      state = state.copyWith(
          movies: [], page: 1, searchCategory: _category, searchText: "");
      getMovies();
    } catch (e) {}
  }

  void updateTextSearch(String searchText) {
    try {
      state = state.copyWith(
          movies: [],
          page: 1,
          searchCategory: SearchCategory.none,
          searchText: searchText);
      getMovies();
    } catch (e) {
      print(e);
    }
  }
}
