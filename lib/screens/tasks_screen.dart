import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskFlowScaffold(
      title: 'Mes tâches',
      currentRoute: AppRoutes.tasks,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Nouvelle tâche',
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.checklist_rtl,
                size: 64,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 16),
              Text('Aucune tâche pour le moment', style: AppTextStyles.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Le CRUD et la connexion API arriveront prochainement.',
                style: AppTextStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
