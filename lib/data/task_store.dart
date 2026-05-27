import 'package:flutter/foundation.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_priority.dart';

class TaskStore extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get tasks => List.unmodifiable(_tasks);

  List<Task> get focusTasks => _tasks
      .where((t) => !t.completed && _isFocusCandidate(t))
      .toList()
    ..sort(_compareByUrgency);

  void add(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void update(Task task) {
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index == -1) return;
    _tasks[index] = task;
    notifyListeners();
  }

  void remove(String id) {
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  Task? findById(String id) {
    for (final task in _tasks) {
      if (task.id == id) return task;
    }
    return null;
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
