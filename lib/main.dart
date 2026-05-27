import 'package:flutter/material.dart';
import 'package:taskflow/app.dart';
import 'package:taskflow/data/rest_task_repository.dart';
import 'package:taskflow/data/task_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final taskStore = TaskStore(RestTaskRepository());
  runApp(TaskFlowApp(taskStore: taskStore));
}
