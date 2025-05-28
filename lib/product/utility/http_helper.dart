import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper._();

  static final String _baseURL =
      kIsWeb ? 'http://localhost:3000/api/' : 'http://10.0.2.2:3000/api/';

  static Future<http.Response> getRequest(
      String endPoint, String? endPointDetail) async {
    final response = await http.get(
        headers: {'Content-Type': 'application/json'},
        Uri.parse(_baseURL + endPoint + '/' + (endPointDetail ?? '')));
    return response;
  }

  static Future<http.Response> postRequest(
      String endPoint, String? endPointDetail, Object? body) async {
    final response = await http.post(
        headers: {'Content-Type': 'application/json'},
        // Uri.parse('http://10.0.2.2:3000/api/users/login'),
        Uri.parse(_baseURL + endPoint + '/' + (endPointDetail ?? '')),
        body: jsonEncode(body));
    return response;
  }
}
