import 'package:dummy_project_users_search/repository/logs/logs_repo.dart';

import '../../data/remote/abstract_api_service.dart';
import '../../data/remote/api_endpoints.dart';
import '../../data/remote/api_service.dart';

class LogsRepoImp extends LogsRepo{
  final AbstractApiService _apiService = ApiService();

  @override
  Future fetchLogs() {
    try {
      dynamic response = _apiService.getLogs(ApiEndpoints.logs);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}