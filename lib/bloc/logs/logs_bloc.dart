import 'package:bloc/bloc.dart';
import 'package:dummy_project_users_search/data/model/log_model.dart';
import 'package:dummy_project_users_search/data/model/page_model.dart';
import 'package:dummy_project_users_search/data/model/product_model.dart';

import '../../repository/Logs/Logs_repo_imp.dart';
import 'logs_event.dart';
import 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final _logsRepo = LogsRepoImp();
  List<LogModel> logs = [];

  LogsBloc() : super(LogsInitial()) {
    on<FetchLogsEvent>(loadLogs);
    on<FetchLogsPaginationEvent>(loadLogsMore);

  }

  void loadLogs(FetchLogsEvent event, Emitter<LogsState> emit) async {
    emit(LogsLoading());
    try {
      List logsData = await _logsRepo.fetchLogs();
      var logsDataModels = List<LogModel>.from(logsData.map((e) => LogModel.fromJson(e)));
      var logsSorted = getSortedLogs(logsDataModels).skip(0).take(20).toList();
      print(logsData);
      var productPageModel = PageModel<LogModel>(data: logsSorted, total: logs.length, skip: 0, limit: 20);
      emit(LogsLoaded(productPageModel));
    } catch (e) {
      print(e);
      emit(LogsError(e.toString()));
    }
  }

  List<LogModel> getSortedLogs(List<LogModel> logsData) {
    logs = List.of(logsData)..sort((a, b) => b.id!.compareTo(a.id!));
    return logs;
  }

  void loadLogsMore(FetchLogsPaginationEvent event, Emitter<LogsState> emit) async {
    //emit(LogsLoading());
    try {
      var skip = event.page * 20;
      var logsSorted = logs.skip(skip).take(20).toList();
      var productPageModel = PageModel<LogModel>(data: logsSorted, total: logs.length, skip: skip, limit: 20);
      emit(LogsLoaded(productPageModel));
    } catch (e) {
      print(e);
      emit(LogsError(e.toString()));
    }
  }

}
