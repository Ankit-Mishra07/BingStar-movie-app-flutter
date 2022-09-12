import 'package:client/models/movie_model.dart';
import 'package:client/services/api_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late ApiService api;
  MovieService() {
    api = getIt.get<ApiService>();
  }

  Future<List<MovieModel>> getPopularMovies({required int page}) async {
    Response _response = await api.get("/movie/popular", query: {
      "page": page,
    });
    if (_response.statusCode == 200) {
      Map _data = _response.data;
      List<MovieModel> movies = _data["results"].map<MovieModel>((_movieData) {
        return MovieModel.fromJson(_movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't load popular movies.");
    }
  }

  Future<List<MovieModel>> getUpcomingMovies({required int page}) async {
    Response _response = await api.get("/movie/upcoming", query: {
      "page": page,
    });
    if (_response.statusCode == 200) {
      Map _data = _response.data;
      List<MovieModel> movies = _data["results"].map<MovieModel>((_movieData) {
        return MovieModel.fromJson(_movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't load upcoming movies.");
    }
  }

  Future<List<MovieModel>> searchMovies(String _searchTerm,
      {required int page}) async {
    Response _response = await api.get("/search/movie", query: {
      "query": _searchTerm,
      "page": page,
    });
    if (_response.statusCode == 200) {
      Map _data = _response.data;
      List<MovieModel> movies = _data["results"].map<MovieModel>((_movieData) {
        return MovieModel.fromJson(_movieData);
      }).toList();
      return movies;
    } else {
      throw Exception("Couldn't load searched movies.");
    }
  }
}
