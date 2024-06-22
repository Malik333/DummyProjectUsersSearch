import 'package:flutter/material.dart';

@immutable
abstract class ProductsEvent {}


class FetchProductsEvent extends ProductsEvent {}

class FetchProductPaginationEvent extends ProductsEvent {
  final int page;
  FetchProductPaginationEvent(this.page);
}
class FetchProductsSearchEvent extends ProductsEvent {
  final String query;
  FetchProductsSearchEvent(this.query);
}

class FetchProductSearchPaginationEvent extends ProductsEvent {
  final String query;
  final int page;
  FetchProductSearchPaginationEvent(this.query, this.page);
}