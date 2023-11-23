import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:film_app/util/config_setter.dart';

Future<http.Response> fetchApiCall(String urlPath,
    {String? apiKey, Map<String, dynamic>? queryParams}) async {
  String usedApiKey =
      apiKey ?? jsonDecode(await getConfig())['api_config']['api_key'];
  http.Response response = await http.get(Uri.https('api.themoviedb.org',
      '/3/${urlPath}', {'api_key': usedApiKey, ...?queryParams}));
  return response;
}
