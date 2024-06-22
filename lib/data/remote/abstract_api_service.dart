abstract class AbstractApiService {
  final String baseUrl = "dummyjson.com";
  final String logBaseUrl = "raw.githubusercontent.com";

  Future<dynamic> login(String url, String username, String password);
  Future<dynamic> fetchProfile(String url);
  Future<dynamic> getProducts(String url);
  Future<dynamic> getProductPagination(String url, int page);
  Future<dynamic> getProductsSearch(String url, String query);
  Future<dynamic> getProductsSearchPagination(String url, String query, int page);
  Future<dynamic> getLogs(String url);

}