import 'package:flutter_test/flutter_test.dart';
import 'package:taskflow/app.dart';

void main() {
  testWidgets('TaskFlow affiche l\'écran d\'accueil', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskFlowApp());
    await tester.pumpAndSettle();

    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Bonjour 👋'), findsOneWidget);
  });

  testWidgets('Le drawer permet de naviguer vers Mes tâches', (WidgetTester tester) async {
    await tester.pumpWidget(const TaskFlowApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Mes tâches'));
    await tester.pumpAndSettle();

    expect(find.text('Aucune tâche pour le moment'), findsOneWidget);
  });
}
