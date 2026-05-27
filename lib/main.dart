import 'package:flutter/material.dart';
import 'package:taskflow/app.dart';
import 'package:taskflow/data/task_store.dart';

void main() {
  final taskStore = TaskStore();
  runApp(TaskFlowApp(taskStore: taskStore));
}
