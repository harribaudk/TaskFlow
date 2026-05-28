import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskflow/auth/auth_controller.dart';
import 'package:taskflow/data/task_store.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/screens/focus_screen.dart';
import 'package:taskflow/screens/home_screen.dart';
import 'package:taskflow/screens/login_screen.dart';
import 'package:taskflow/screens/register_screen.dart';
import 'package:taskflow/screens/settings_screen.dart';
import 'package:taskflow/screens/tasks_screen.dart';
import 'package:taskflow/theme/app_theme.dart';
import 'package:taskflow/widgets/auth_scope.dart';
import 'package:taskflow/widgets/task_store_scope.dart';

class TaskFlowApp extends StatefulWidget {
  const TaskFlowApp({
    super.key,
    required this.taskStore,
    required this.authController,
  });

  final TaskStore taskStore;
  final AuthController authController;

  @override
  State<TaskFlowApp> createState() => _TaskFlowAppState();
}

class _TaskFlowAppState extends State<TaskFlowApp> {
  @override
  void initState() {
    super.initState();
    widget.authController.addListener(_onAuthChanged);
    widget.authController.init();
  }

  @override
  void dispose() {
    widget.authController.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    if (widget.authController.isAuthenticated && !widget.taskStore.isLoading) {
      final hasTasks = widget.taskStore.tasks.isNotEmpty;
      if (!hasTasks) {
        widget.taskStore.load();
      }
    }
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    final auth = widget.authController;
    var name = settings.name ?? AppRoutes.login;

    if (auth.isInitializing) {
      return MaterialPageRoute<void>(
        builder: (_) => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (!auth.isAuthenticated) {
      if (name == AppRoutes.register) {
        return MaterialPageRoute<void>(builder: (_) => const RegisterScreen());
      }
      return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
    }

    if (name == AppRoutes.login || name == AppRoutes.register) {
      return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
    }

    switch (name) {
      case AppRoutes.tasks:
        return MaterialPageRoute<void>(builder: (_) => const TasksScreen());
      case AppRoutes.focus:
        return MaterialPageRoute<void>(builder: (_) => const FocusScreen());
      case AppRoutes.settings:
        return MaterialPageRoute<void>(builder: (_) => const SettingsScreen());
      default:
        return MaterialPageRoute<void>(builder: (_) => const HomeScreen());
    }
  }

  String get _initialRoute {
    if (widget.authController.isInitializing) {
      return AppRoutes.login;
    }
    return widget.authController.isAuthenticated
        ? AppRoutes.home
        : AppRoutes.login;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.authController,
      builder: (context, _) {
        return AuthScope(
          auth: widget.authController,
          child: TaskStoreScope(
            store: widget.taskStore,
            child: MaterialApp(
              key: ValueKey(
                '${widget.authController.isAuthenticated}_'
                '${widget.authController.isInitializing}',
              ),
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
              initialRoute: _initialRoute,
              onGenerateRoute: _onGenerateRoute,
            ),
          ),
        );
      },
    );
  }
}
