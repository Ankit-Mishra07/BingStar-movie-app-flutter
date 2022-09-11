import 'package:client/models/app_config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ApiService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _baseurl;
  late String _api_key;

  ApiService() {
    // ignore: no_leading_underscores_for_local_identifiers
    AppConfig _config = getIt.get<AppConfig>();
    _baseurl = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }

  Future<Response> get(String _path, {Map<String, dynamic>? query}) async {
    // ignore: no_leading_underscores_for_local_identifiers
    String _url = "$_baseurl$_path";
    // ignore: no_leading_underscores_for_local_identifiers
    Map<String, dynamic> _query = {
      "api_key": _api_key,
      "language": "en-US",
    };

    if (query != null) {
      _query.addAll(query);
    }

    return await dio.get(_url, queryParameters: _query);
  }
}
