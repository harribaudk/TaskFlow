import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskflow/app.dart';
import 'package:taskflow/auth/auth_controller.dart';
import 'package:taskflow/auth/local_auth_service.dart';
import 'package:taskflow/data/in_memory_task_repository.dart';
import 'package:taskflow/data/task_store.dart';

void main() {
  late TaskStore taskStore;
  late AuthController authController;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    taskStore = TaskStore(InMemoryTaskRepository());
    authController = AuthController(LocalAuthService());
    await authController.init();
    await authController.login(
      email: LocalAuthService.demoEmail,
      password: LocalAuthService.demoPassword,
    );
  });

  Widget buildApp() => TaskFlowApp(
        taskStore: taskStore,
        authController: authController,
      );

  testWidgets('TaskFlow affiche l\'écran d\'accueil après connexion', (WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    expect(find.text('Accueil'), findsOneWidget);
    expect(find.text('Bonjour !'), findsOneWidget);
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

  testWidgets('Sans connexion, l\'écran de login s\'affiche', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    final guestAuth = AuthController(LocalAuthService());
    await guestAuth.init();

    await tester.pumpWidget(
      TaskFlowApp(taskStore: taskStore, authController: guestAuth),
    );
    await tester.pumpAndSettle();

    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
  });
}
