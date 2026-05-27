import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.category,
    required this.priority,
    this.deadline,
    this.completed = false,
  });

  final String id;
  final String title;
  final String? description;
  final TaskCategory category;
  final TaskPriority priority;
  final DateTime? deadline;
  final bool completed;

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool clearDescription = false,
    TaskCategory? category,
    TaskPriority? priority,
    DateTime? deadline,
    bool clearDeadline = false,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: clearDescription ? null : (description ?? this.description),
      category: category ?? this.category,
      priority: priority ?? this.priority,
      deadline: clearDeadline ? null : (deadline ?? this.deadline),
      completed: completed ?? this.completed,
    );
  }
}
