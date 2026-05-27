import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/data/task_store.dart';
import 'package:taskflow/screens/task_form_screen.dart';

void main() {
  late TaskStore taskStore;

  setUp(() {
    taskStore = TaskStore();
  });

  testWidgets('Le formulaire exige un titre', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskFormScreen(taskStore: taskStore),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('task_form_save')));
    await tester.pumpAndSettle();

    expect(find.text('Le titre est obligatoire'), findsOneWidget);
  });

  testWidgets('Le formulaire crée une tâche', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: TaskFormScreen(taskStore: taskStore),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, 'Réviser le cours');
    await tester.tap(find.byKey(const Key('task_form_save')));
    await tester.pumpAndSettle();

    expect(taskStore.tasks, hasLength(1));
    expect(taskStore.tasks.first.title, 'Réviser le cours');
  });
}
