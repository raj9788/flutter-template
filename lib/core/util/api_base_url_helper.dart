import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../errors/app_exceptions.dart';

class ApiBaseHelper {
  // Singleton setup
  ApiBaseHelper._privateConstructor();
  static final ApiBaseHelper _instance = ApiBaseHelper._privateConstructor();
  factory ApiBaseHelper() => _instance;

  // TODO: Set your actual base URL here
  final String _baseUrl = ""; // e.g., "https://api.example.com/";

  // Shared headers
  Map<String, String> _headers({String? token}) => {
        'accept': '*/*',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

  // GET without token
  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // GET with token
  Future<dynamic> fetch(String url, String token) async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: _headers(token: token),
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // POST with token
  Future<dynamic> post(String url, dynamic data, String token) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + url),
        body: json.encode(data),
        headers: _headers(token: token),
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // POST without token (e.g., login)
  Future<dynamic> access(String url, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl + url),
        body: json.encode(data),
        headers: _headers(),
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // PUT
  Future<dynamic> put(String url, dynamic data, String token) async {
    try {
      final response = await http.put(
        Uri.parse(_baseUrl + url),
        body: json.encode(data),
        headers: _headers(token: token),
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // PATCH
  Future<dynamic> patch(String url, dynamic data, String token) async {
    try {
      final response = await http.patch(
        Uri.parse(_baseUrl + url),
        body: json.encode(data),
        headers: _headers(token: token),
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // DELETE
  Future<dynamic> delete(String url, String token) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl + url),
        headers: _headers(token: token),
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  // Response handler
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 503:
        throw ServerException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occurred while communicating with server. '
          'Status Code: ${response.statusCode}',
        );
    }
  }
}
