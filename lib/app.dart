import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/screens/categories_screen.dart';
import 'package:taskflow/screens/focus_screen.dart';
import 'package:taskflow/screens/home_screen.dart';
import 'package:taskflow/screens/settings_screen.dart';
import 'package:taskflow/screens/tasks_screen.dart';
import 'package:taskflow/theme/app_theme.dart';

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (_) => const HomeScreen(),
        AppRoutes.tasks: (_) => const TasksScreen(),
        AppRoutes.focus: (_) => const FocusScreen(),
        AppRoutes.categories: (_) => const CategoriesScreen(),
        AppRoutes.settings: (_) => const SettingsScreen(),
      },
    );
  }
}
