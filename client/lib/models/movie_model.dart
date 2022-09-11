import 'package:client/models/app_config.dart';
import 'package:get_it/get_it.dart';

class MovieModel {
  final String name;
  final String language;
  final bool isAdult;
  final String description;
  final String posterPath;
  final String backdropPath;
  final num rating;
  final String releaseDate;

  MovieModel({
    required this.name,
    required this.language,
    required this.isAdult,
    required this.description,
    required this.posterPath,
    required this.backdropPath,
    required this.rating,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> _json) {
    return MovieModel(
      name: _json["title"],
      language: _json["original_language"],
      isAdult: _json["adult"],
      description: _json["overview"],
      posterPath: _json["poster_path"],
      backdropPath: _json["backdrop_path"],
      rating: _json["vote_average"],
      releaseDate: _json["release_date"],
    );
  }

  String posterUrl() {
    final AppConfig appConfig = GetIt.instance.get<AppConfig>();
    return "${appConfig.BASE_IMAGE_API_URL}$posterPath";
  }
}
