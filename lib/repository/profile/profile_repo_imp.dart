import 'package:dummy_project_users_search/data/remote/api_endpoints.dart';
import 'package:dummy_project_users_search/repository/profile/profile_repo.dart';

import '../../data/remote/abstract_api_service.dart';
import '../../data/remote/api_service.dart';

class ProfileRepoImp extends ProfileRepo{
  final AbstractApiService _apiService = ApiService();
  static const int _pageSize = 15;

  @override
  Future fetchProfile() {
    try {
      dynamic response = _apiService.fetchProfile(ApiEndpoints.myProfile);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}