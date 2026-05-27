import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/api/task_json_mapper.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';

void main() {
  test('fromJson parse une tâche', () {
    final task = TaskJsonMapper.fromJson({
      'id': '42',
      'title': 'Réunion',
      'description': 'Préparer slides',
      'category': 'travail',
      'priority': 'high',
      'deadline': '2026-05-27T10:00:00.000Z',
      'completed': false,
    });

    expect(task.id, '42');
    expect(task.title, 'Réunion');
    expect(task.category, TaskCategory.travail);
    expect(task.priority, TaskPriority.high);
    expect(task.deadline, isNotNull);
  });

  test('listFromJson accepte un tableau ou un objet items', () {
    final fromList = TaskJsonMapper.listFromJson([
      {'id': '1', 'title': 'A', 'category': 'maison', 'priority': 'low'},
    ]);
    final fromWrapper = TaskJsonMapper.listFromJson({
      'items': [
        {'id': '2', 'title': 'B', 'category': 'etudes', 'priority': 'medium'},
      ],
    });

    expect(fromList, hasLength(1));
    expect(fromWrapper, hasLength(1));
  });
}
