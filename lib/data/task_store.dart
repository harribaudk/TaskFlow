import 'package:flutter/foundation.dart';
import 'package:taskflow/api/api_exception.dart';
import 'package:taskflow/data/task_repository.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

class TaskStore extends ChangeNotifier {
  TaskStore(this._repository);

  final TaskRepository _repository;
  final List<Task> _tasks = [];

  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;

  List<Task> get tasks => List.unmodifiable(_tasks);

  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;
  String? get error => _error;

  List<Task> get focusTasks => _tasks
      .where((t) => !t.completed && _isFocusCandidate(t))
      .toList()
    ..sort(_compareByUrgency);

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetched = await _repository.fetchAll();
      _tasks
        ..clear()
        ..addAll(fetched);
      _error = null;
    } on ApiException catch (e) {
      _error = e.message;
    } catch (_) {
      _error = 'Impossible de joindre l\'API. Vérifiez que le serveur est démarré.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Task?> create({
    required String title,
    String? description,
    required TaskCategory category,
    required TaskPriority priority,
    DateTime? deadline,
    String? photoPath,
  }) async {
    return _runSaving(() async {
      final task = await _repository.create(
        title: title,
        description: description,
        category: category,
        priority: priority,
        deadline: deadline,
        photoPath: photoPath,
      );
      _tasks.add(task);
      return task;
    });
  }

  Future<Task?> update(Task task) async {
    return _runSaving(() async {
      final updated = await _repository.update(task);
      final index = _tasks.indexWhere((t) => t.id == updated.id);
      if (index != -1) _tasks[index] = updated;
      return updated;
    });
  }

  Future<bool> remove(String id) async {
    final result = await _runSaving(() async {
      await _repository.delete(id);
      _tasks.removeWhere((t) => t.id == id);
      return true;
    });
    return result == true;
  }

  Task? findById(String id) {
    for (final task in _tasks) {
      if (task.id == id) return task;
    }
    return null;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<T?> _runSaving<T>(Future<T> Function() action) async {
    _isSaving = true;
    _error = null;
    notifyListeners();

    try {
      final result = await action();
      _error = null;
      return result;
    } on ApiException catch (e) {
      _error = e.message;
      return null;
    } catch (_) {
      _error = 'Échec de l\'enregistrement. Réessayez.';
      return null;
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }

  bool _isFocusCandidate(Task task) {
    if (task.priority == TaskPriority.high) return true;
    final deadline = task.deadline;
    if (deadline == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDay = DateTime(deadline.year, deadline.month, deadline.day);
    return !dueDay.isAfter(today);
  }

  int _compareByUrgency(Task a, Task b) {
    final priorityCompare = b.priority.index.compareTo(a.priority.index);
    if (priorityCompare != 0) return priorityCompare;
    final aDeadline = a.deadline;
    final bDeadline = b.deadline;
    if (aDeadline == null && bDeadline == null) return 0;
    if (aDeadline == null) return 1;
    if (bDeadline == null) return -1;
    return aDeadline.compareTo(bDeadline);
  }
}
