import 'package:dummy_project_users_search/repository/products/product_repo.dart';

import '../../data/remote/abstract_api_service.dart';
import '../../data/remote/api_endpoints.dart';
import '../../data/remote/api_service.dart';

class ProductsRepoImp extends ProductsRepo {
  final AbstractApiService _apiService = ApiService();

  @override
  Future getProducts() {
    try {
      dynamic response = _apiService.getProducts(ApiEndpoints.products);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getProductPagination(int page) {
    try {
      dynamic response = _apiService.getProductPagination(ApiEndpoints.products, page);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getProductsSearch(String query) {
    try {
      dynamic response = _apiService.getProductsSearch(ApiEndpoints.productsSearch, query);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getProductsSearchPagination(String query, int page) {
    try {
      dynamic response = _apiService.getProductsSearchPagination(ApiEndpoints.productsSearch, query, page);
      return response;
    } catch (e) {
      rethrow;
    }
  }

}