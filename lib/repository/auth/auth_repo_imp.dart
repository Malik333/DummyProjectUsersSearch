import 'package:dummy_project_users_search/data/remote/abstract_api_service.dart';
import 'package:dummy_project_users_search/data/remote/api_endpoints.dart';
import 'package:dummy_project_users_search/data/remote/api_service.dart';

import 'auth_repo.dart';

class AuthRepoImp extends AuthRepo {

  final AbstractApiService _apiService = ApiService();
  static const int _pageSize = 15;

  @override
  Future login({required String email, required String password}) {
    try {
      dynamic response = _apiService.login(ApiEndpoints.login, email, password);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}