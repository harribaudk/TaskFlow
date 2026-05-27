import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

abstract final class TaskJsonMapper {
  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'].toString(),
      title: json['title'] as String,
      description: json['description'] as String?,
      category: _parseCategory(json['category'] as String),
      priority: _parsePriority(json['priority'] as String),
      deadline: _parseDeadline(json['deadline']),
      completed: json['completed'] as bool? ?? false,
    );
  }

  static List<Task> listFromJson(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(fromJson)
          .toList();
    }
    if (data is Map<String, dynamic>) {
      final items = data['items'] ?? data['data'] ?? data['tasks'];
      if (items is List) {
        return items
            .whereType<Map<String, dynamic>>()
            .map(fromJson)
            .toList();
      }
    }
    throw const FormatException('Format de liste de tâches non reconnu');
  }

  static Map<String, dynamic> toCreateJson({
    required String title,
    String? description,
    required TaskCategory category,
    required TaskPriority priority,
    DateTime? deadline,
  }) {
    return {
      'title': title,
      if (description != null && description.isNotEmpty)
        'description': description,
      'category': category.name,
      'priority': priority.name,
      if (deadline != null) 'deadline': deadline.toUtc().toIso8601String(),
      'completed': false,
    };
  }

  static Map<String, dynamic> toUpdateJson(Task task) {
    return {
      'title': task.title,
      'description': task.description,
      'category': task.category.name,
      'priority': task.priority.name,
      'deadline': task.deadline?.toUtc().toIso8601String(),
      'completed': task.completed,
    };
  }

  static TaskCategory _parseCategory(String value) {
    return TaskCategory.values.firstWhere(
      (c) => c.name == value,
      orElse: () => TaskCategory.travail,
    );
  }

  static TaskPriority _parsePriority(String value) {
    return TaskPriority.values.firstWhere(
      (p) => p.name == value,
      orElse: () => TaskPriority.medium,
    );
  }

  static DateTime? _parseDeadline(dynamic value) {
    if (value == null) return null;
    return DateTime.parse(value as String).toLocal();
  }
}
