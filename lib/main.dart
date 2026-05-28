import 'package:flutter/material.dart';
import 'package:taskflow/app.dart';
import 'package:taskflow/auth/auth_controller.dart';
import 'package:taskflow/auth/local_auth_service.dart';
import 'package:taskflow/data/rest_task_repository.dart';
import 'package:taskflow/data/task_store.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final taskStore = TaskStore(RestTaskRepository());
  final authController = AuthController(LocalAuthService());
  runApp(TaskFlowApp(taskStore: taskStore, authController: authController));
}
