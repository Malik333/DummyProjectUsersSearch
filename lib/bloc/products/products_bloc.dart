import 'package:bloc/bloc.dart';
import 'package:dummy_project_users_search/data/model/page_model.dart';
import 'package:dummy_project_users_search/data/model/product_model.dart';

import '../../data/remote/api_exception.dart';
import '../../repository/products/products_repo_imp.dart';
import 'products_event.dart';
import 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  var _productsRepo = ProductsRepoImp();

  ProductsBloc() : super(ProductsInitial()) {
    on<FetchProductsEvent>(loadProducts);
    on<FetchProductPaginationEvent>(loadProductsMore);
    on<FetchProductsSearchEvent>(searchProducts);
    on<FetchProductSearchPaginationEvent>(searchLoadProductsMore);

  }

  void loadProducts(FetchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      var products = await _productsRepo.getProducts();
      var productPageModel = PageModel<ProductModel>.fromJson(products, (json) {
        return ProductModel.fromJson(json);
      });
      emit(ProductsLoaded(productPageModel));
    }  on  UnauthorisedException catch (e) {
      emit(AuthenticationProductUnauthenticated());
    } catch (e) {
      print(e);
      emit(ProductsError(e.toString()));
    }
  }

  void loadProductsMore(FetchProductPaginationEvent event, Emitter<ProductsState> emit) async {
    //emit(ProductsLoading());
    try {
      var products = await _productsRepo.getProductPagination(event.page);
      var productPageModel = PageModel<ProductModel>.fromJson(products, (json) {
        return ProductModel.fromJson(json);
      });
      emit(ProductsLoaded(productPageModel));
    } on  UnauthorisedException catch (e) {
      emit(AuthenticationProductUnauthenticated());
    } catch (e) {
      print(e);
      emit(ProductsError(e.toString()));
    }
  }

  void searchProducts(FetchProductsSearchEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());
    try {
      var products = await _productsRepo.getProductsSearch(event.query);
      var productPageModel = PageModel<ProductModel>.fromJson(products, (json) {
        return ProductModel.fromJson(json);
      });
      emit(ProductsLoaded(productPageModel));
    }  on  UnauthorisedException catch (e) {
      emit(AuthenticationProductUnauthenticated());
    } catch (e) {
      print(e);
      emit(ProductsError(e.toString()));
    }
  }

  void searchLoadProductsMore(FetchProductSearchPaginationEvent event, Emitter<ProductsState> emit) async {
    //emit(ProductsLoading());
    try {
      var products = await _productsRepo.getProductsSearchPagination(event.query, event.page);
      var productPageModel = PageModel<ProductModel>.fromJson(products, (json) {
        return ProductModel.fromJson(json);
      });
      emit(ProductsLoaded(productPageModel));
    }  on  UnauthorisedException catch (e) {
      emit(AuthenticationProductUnauthenticated());
    } catch (e) {
      print(e);
      emit(ProductsError(e.toString()));
    }
  }

}
