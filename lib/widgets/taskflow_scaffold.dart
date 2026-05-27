import 'package:flutter/material.dart';
import 'package:taskflow/widgets/taskflow_drawer.dart';

class TaskFlowScaffold extends StatelessWidget {
  const TaskFlowScaffold({
    super.key,
    required this.title,
    required this.currentRoute,
    required this.body,
    this.floatingActionButton,
  });

  final String title;
  final String currentRoute;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: TaskFlowDrawer(currentRoute: currentRoute),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
