import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskflow/data/task_store.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/screens/focus_screen.dart';
import 'package:taskflow/screens/home_screen.dart';
import 'package:taskflow/screens/settings_screen.dart';
import 'package:taskflow/screens/tasks_screen.dart';
import 'package:taskflow/theme/app_theme.dart';
import 'package:taskflow/widgets/task_store_scope.dart';

class TaskFlowApp extends StatefulWidget {
  const TaskFlowApp({super.key, required this.taskStore});

  final TaskStore taskStore;

  @override
  State<TaskFlowApp> createState() => _TaskFlowAppState();
}

class _TaskFlowAppState extends State<TaskFlowApp> {
  @override
  void initState() {
    super.initState();
    widget.taskStore.load();
  }

  @override
  Widget build(BuildContext context) {
    return TaskStoreScope(
      store: widget.taskStore,
      child: MaterialApp(
        title: 'TaskFlow',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        locale: const Locale('fr', 'FR'),
        supportedLocales: const [Locale('fr', 'FR')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (_) => const HomeScreen(),
          AppRoutes.tasks: (_) => const TasksScreen(),
          AppRoutes.focus: (_) => const FocusScreen(),
          AppRoutes.settings: (_) => const SettingsScreen(),
        },
      ),
    );
  }
}
