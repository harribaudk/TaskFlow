import 'package:taskflow/data/task_repository.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

class InMemoryTaskRepository implements TaskRepository {
  final List<Task> _tasks = [];
  int _idCounter = 1;

  @override
  Future<List<Task>> fetchAll() async => List.unmodifiable(_tasks);

  @override
  Future<Task> create({
    required String title,
    String? description,
    required TaskCategory category,
    required TaskPriority priority,
    DateTime? deadline,
  }) async {
    final task = Task(
      id: (_idCounter++).toString(),
      title: title,
      description: description,
      category: category,
      priority: priority,
      deadline: deadline,
    );
    _tasks.add(task);
    return task;
  }

  @override
  Future<Task> update(Task task) async {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index == -1) throw StateError('Tâche introuvable');
    _tasks[index] = task;
    return task;
  }

  @override
  Future<void> delete(String id) async {
    _tasks.removeWhere((t) => t.id == id);
  }
}
