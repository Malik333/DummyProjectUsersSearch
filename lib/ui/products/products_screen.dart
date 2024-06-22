import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_bloc.dart';
import 'package:dummy_project_users_search/bloc/auth/auth_event.dart';
import 'package:dummy_project_users_search/bloc/products/products_state.dart';
import 'package:dummy_project_users_search/data/cache/auth_cache_manager.dart';
import 'package:dummy_project_users_search/data/model/credentials_model.dart';
import 'package:dummy_project_users_search/data/model/product_model.dart';

import '../../bloc/auth/auth_state.dart';
import '../../bloc/products/products_bloc.dart';
import '../../bloc/products/products_event.dart';
import '../login/login_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final pagingController = PagingController<int, ProductModel>(
    firstPageKey: 0,
  );

  Timer? _debounce;
  String _searchText = '';
  CredentialsModel? credentialsModel;

  var authManager = AuthCacheManager();

  @override
  void initState() {
    super.initState();
    getCredentials();
  }

  void getCredentials() async {
    credentialsModel = await authManager.getUserCredentials();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              ProductsBloc()..add(FetchProductsEvent()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
      ],
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ProductsBloc>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 0) return;

      if (_searchText.isEmpty) {
        bloc.add(FetchProductPaginationEvent(pageKey));
      } else {
        bloc.add(FetchProductSearchPaginationEvent(_searchText, pageKey));
      }
    });

    return Container(
      color: Colors.white60,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
            child: TextField(
              onChanged: (text) {
                _searchText = text;
                if (_debounce?.isActive ?? false) _debounce?.cancel();
                _debounce = Timer(const Duration(milliseconds: 500), () {
                  pagingController.refresh();
                  pagingController.value = const PagingState<int, ProductModel>(
                    nextPageKey: 0,
                    itemList: [],
                    error: null,
                  );
                  if (text.isEmpty) {
                    bloc.add(FetchProductsEvent());
                  } else {
                    bloc.add(FetchProductsSearchEvent(text));
                  }
                });
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                hintText: 'Search products...',
              ),
            ),
          ),
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            return Container();
          }, listener: (context, state) {
            if (state is AuthenticationAuthenticated) {
              if (_searchText.isEmpty) {
                bloc.add(FetchProductsEvent());
              } else {
                bloc.add(FetchProductsSearchEvent(_searchText));
              }
            } else if (state is ErrorAuthenticationState) {
              authBloc.add(LogoutRequested());
            } else if (state is AuthenticationUnauthenticated) {
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.route, (route) => false);
            } else if (state is AuthenticationFailedAuthenticated) {
              authBloc.add(LogoutRequested());
            }
          }),
          BlocConsumer<ProductsBloc, ProductsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is ProductsError) {
                return Center(
                  child: Text(state.error),
                );
              }

              if (state is ProductsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is AuthenticationProductUnauthenticated) {
                authBloc.add(RefreshLoginRequested(
                    credentialsModel!.email, '${credentialsModel!.password}2'));
              }

              if (state is ProductsLoaded) {
                var productPageModel = state.productPageModel;

                if (productPageModel.isLastPage!) {
                  pagingController.appendLastPage(productPageModel.data!);
                } else {
                  pagingController.appendPage(state.productPageModel.data!,
                      (pagingController.nextPageKey ?? 0) + 1);
                }
              }

              return Expanded(
                child: PagedListView<int, ProductModel>.separated(
                  shrinkWrap: true,
                  pagingController: pagingController,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => const SizedBox(),
                  builderDelegate: PagedChildBuilderDelegate<ProductModel>(
                    itemBuilder: (context, productModel, index) {
                      return Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      productModel.thumbnail!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        productModel.title!,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        productModel.description!,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                          '\$ ${productModel.price.toString()}'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                    firstPageErrorIndicatorBuilder: (context) => const SizedBox(
                      height: 20,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
