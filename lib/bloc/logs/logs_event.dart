import 'package:flutter/material.dart';

@immutable
abstract class LogsEvent {}


class FetchLogsEvent extends LogsEvent {}

class FetchLogsPaginationEvent extends LogsEvent {
  final int page;
  FetchLogsPaginationEvent(this.page);
}