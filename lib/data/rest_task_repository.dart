import 'package:taskflow/api/task_api_client.dart';
import 'package:taskflow/data/task_repository.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

class RestTaskRepository implements TaskRepository {
  RestTaskRepository({TaskApiClient? apiClient})
      : _api = apiClient ?? TaskApiClient();

  final TaskApiClient _api;

  @override
  Future<List<Task>> fetchAll() => _api.fetchAll();

  @override
  Future<Task> create({
    required String title,
    String? description,
    required TaskCategory category,
    required TaskPriority priority,
    DateTime? deadline,
  }) =>
      _api.create(
        title: title,
        description: description,
        category: category,
        priority: priority,
        deadline: deadline,
      );

  @override
  Future<Task> update(Task task) => _api.update(task);

  @override
  Future<void> delete(String id) => _api.delete(id);
}
