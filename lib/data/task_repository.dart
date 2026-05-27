import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

abstract class TaskRepository {
  Future<List<Task>> fetchAll();

  Future<Task> create({
    required String title,
    String? description,
    required TaskCategory category,
    required TaskPriority priority,
    DateTime? deadline,
  });

  Future<Task> update(Task task);

  Future<void> delete(String id);
}
