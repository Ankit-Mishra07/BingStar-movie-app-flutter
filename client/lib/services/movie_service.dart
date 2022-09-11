import 'package:client/services/api_service.dart';
import 'package:get_it/get_it.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;
  late ApiService api;
  MovieService() {
    api = getIt.get<ApiService>();
  }
}
