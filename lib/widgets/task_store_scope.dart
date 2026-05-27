import 'package:flutter/material.dart';
import 'package:taskflow/data/task_store.dart';

class TaskStoreScope extends InheritedWidget {
  const TaskStoreScope({
    super.key,
    required this.store,
    required super.child,
  });

  final TaskStore store;

  static TaskStore of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<TaskStoreScope>();
    assert(scope != null, 'TaskStoreScope introuvable dans l\'arbre de widgets');
    return scope!.store;
  }

  @override
  bool updateShouldNotify(TaskStoreScope oldWidget) =>
      store != oldWidget.store;
}
