import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:dummy_project_users_search/data/cache/auth_cache_manager.dart';
import 'package:dummy_project_users_search/data/remote/abstract_api_service.dart';

import 'api_exception.dart';

class ApiService extends AbstractApiService {
  final AuthCacheManager _authCacheManager = AuthCacheManager();

  @override
  Future login(String url, String username, String password) async {
    dynamic responseJson;

    try {
      var query = {
        "username": username,
        "password": password,
        "expiresInMins": '10',
      };
      var uri = Uri.https(baseUrl, url);
      final response = await http.post(uri, body: query);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is ApiException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }

    return responseJson;
  }

  @override
  Future fetchProfile(String url) async {
    dynamic responseJson;
    try {
      var uri = Uri.https(baseUrl, url);
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer ${await _authCacheManager.getToken()}"
      });
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is FetchDataException) {
        throw FetchDataException(e.toString());
      } else if (e is UnauthorisedException) {
        throw UnauthorisedException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }

    return responseJson;
  }

  @override
  Future getProductPagination(String url, int page) async {
    dynamic responseJson;
    try {
      var skip = page * 15;
      var params = {"skip": skip.toString(), "limit": "15"};
      var uri = Uri.https(baseUrl, url, params);
      print(uri.toString());
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer ${await _authCacheManager.getToken()}"
      });
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is FetchDataException) {
        throw FetchDataException(e.toString());
      } else if (e is UnauthorisedException) {
        throw UnauthorisedException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }

    return responseJson;
  }

  @override
  Future getProducts(String url) async {
    dynamic responseJson;
    try {
      var params = {"skip": "0", "limit": "15"};
      var uri = Uri.https(baseUrl, url, params);
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer ${await _authCacheManager.getToken()}"
      });
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is FetchDataException) {
        throw FetchDataException(e.toString());
      } else if (e is UnauthorisedException) {
        throw UnauthorisedException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }

    return responseJson;
  }

  @override
  Future getProductsSearch(String url, String query) async {
    dynamic responseJson;
    try {
      var params = {"skip": "0", "limit": "15", "q": query};
      var uri = Uri.https(baseUrl, url, params);
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer ${await _authCacheManager.getToken()}"
      });
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is FetchDataException) {
        throw FetchDataException(e.toString());
      } else if (e is UnauthorisedException) {
        throw UnauthorisedException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }

    return responseJson;
  }

  @override
  Future getProductsSearchPagination(String url, String query, int page) async {
    dynamic responseJson;
    try {
      var skip = page * 15;
      var params = {"skip": skip.toString(), "limit": "15", "q": query};
      var uri = Uri.https(baseUrl, url, params);
      print(uri.toString());
      final response = await http.get(uri, headers: {
        "Authorization": "Bearer ${await _authCacheManager.getToken()}"
      });
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is FetchDataException) {
        throw FetchDataException(e.toString());
      } else if (e is UnauthorisedException) {
        throw UnauthorisedException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }

    return responseJson;
  }

  @override
  Future getLogs(String url) async {
    dynamic responseJson;
    try {
      var uri = Uri.https(logBaseUrl, url);
      print(uri.toString());
      final response = await http.get(uri);
      responseJson = returnResponse(response);
    } catch (e) {
      if (e is ApiException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        throw BadRequestException(responseJson['message']);
      case 401:
      case 403:
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        throw UnauthorisedException(responseJson['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server with status code : ${response.statusCode}');
    }
  }
}
