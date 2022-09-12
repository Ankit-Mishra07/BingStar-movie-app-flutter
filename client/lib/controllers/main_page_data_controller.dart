import 'package:client/models/main_page_data.dart';
import 'package:client/models/movie_model.dart';
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
      _movies = await _moviesService.getPopularMovies(page: state.page);
      state = state.copyWith(
          movies: [...state.movies, ..._movies], page: state.page + 1);
    } catch (e) {}
  }
}
