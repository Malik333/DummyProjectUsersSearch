import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:dummy_project_users_search/bloc/logs/logs_bloc.dart';
import 'package:dummy_project_users_search/bloc/logs/logs_event.dart';
import 'package:dummy_project_users_search/bloc/logs/logs_state.dart';
import 'package:dummy_project_users_search/data/model/log_model.dart';
import 'package:dummy_project_users_search/data/model/product_model.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final pagingController = PagingController<int, LogModel>(
    firstPageKey: 0,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LogsBloc()..add(FetchLogsEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<LogsBloc>(context);

    pagingController.addPageRequestListener((pageKey) {
      if (pageKey == 0) return;

      bloc.add(FetchLogsPaginationEvent(pageKey));
    });

    return Container(
      color: Colors.white60,
      child: Column(
        children: [
          BlocConsumer<LogsBloc, LogsState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is LogsError) {
                return Center(
                  child: Text(state.error),
                );
              }

              if (state is LogsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is LogsLoaded) {
                var productPageModel = state.logPageModel;

                if (productPageModel.isLastPage!) {
                  pagingController.appendLastPage(productPageModel.data!);
                } else {
                  pagingController.appendPage(state.logPageModel.data!,
                      (pagingController.nextPageKey ?? 0) + 1);
                }
              }

              return Expanded(
                child: PagedListView<int, LogModel>.separated(
                  shrinkWrap: true,
                  pagingController: pagingController,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => const SizedBox(),
                  builderDelegate: PagedChildBuilderDelegate<LogModel>(
                    itemBuilder: (context, logModel, index) {
                      var format = DateFormat('dd-MM-yyyy');
                      return Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${logModel.actor!.login} at ${format.format(DateTime.parse(logModel.createdAt!))}',
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        logModel.type ?? '',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        logModel.payload!.description ?? '',
                                        maxLines: 2,
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                      ),
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
