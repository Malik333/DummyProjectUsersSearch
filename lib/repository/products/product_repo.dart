class ProductsRepo {
  Future<dynamic> getProducts() async {}
  Future<dynamic> getProductPagination(int page) async {}
  Future<dynamic> getProductsSearch(String query) async {}
  Future<dynamic> getProductsSearchPagination(String query, int page) async {}
}