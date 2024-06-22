
import 'package:flutter/cupertino.dart';
import 'package:dummy_project_users_search/data/model/log_model.dart';
import 'package:dummy_project_users_search/data/model/page_model.dart';
import 'package:dummy_project_users_search/data/model/product_model.dart';

@immutable
abstract class LogsState {
}
class LogsInitial extends LogsState {}
class LogsLoading extends LogsState {}
class LogsLoaded extends LogsState {
  final PageModel<LogModel> logPageModel;
  LogsLoaded(this.logPageModel);
}

class LogsError extends LogsState {
  final String error;
  LogsError(this.error);
}