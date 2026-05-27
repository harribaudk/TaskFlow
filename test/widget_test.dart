import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/app.dart';
import 'package:taskflow/data/task_store.dart';

void main() {
  late TaskStore taskStore;

  setUp(() {
    taskStore = TaskStore();
  });

  Widget buildApp() => TaskFlowApp(taskStore: taskStore);

  testWidgets('TaskFlow affiche l\'écran d\'accueil', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Bonjour 👋'), findsOneWidget);
  });

  testWidgets('Le drawer permet de naviguer vers Mes tâches', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mes tâches'));
    await tester.pumpAndSettle();

    expect(find.text('Aucune tâche pour le moment'), findsOneWidget);
  });

}
