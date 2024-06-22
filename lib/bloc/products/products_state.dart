
import 'package:flutter/cupertino.dart';
import 'package:dummy_project_users_search/data/model/page_model.dart';
import 'package:dummy_project_users_search/data/model/product_model.dart';

@immutable
abstract class ProductsState {
}
class ProductsInitial extends ProductsState {}
class ProductsLoading extends ProductsState {}
class ProductsLoaded extends ProductsState {
  final PageModel<ProductModel> productPageModel;
  ProductsLoaded(this.productPageModel);
}
class ProductsError extends ProductsState {
  final String error;
  ProductsError(this.error);
}

class AuthenticationProductUnauthenticated extends ProductsState {}