import 'package:flutter/material.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/screens/task_form_screen.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/task_error_banner.dart';
import 'package:taskflow/widgets/task_list_tile.dart';
import 'package:taskflow/widgets/task_store_scope.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  Future<void> _openForm(BuildContext context, {Task? task}) async {
    final store = TaskStoreScope.of(context);
    await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => TaskFormScreen(
          taskStore: store,
          task: task,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = TaskStoreScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final tasks = store.tasks;
        final isLoading = store.isLoading && tasks.isEmpty;

        return TaskFlowScaffold(
          title: 'Mes tâches',
          currentRoute: AppRoutes.tasks,
          floatingActionButton: store.isLoading
              ? null
              : FloatingActionButton(
                  onPressed: () => _openForm(context),
                  tooltip: 'Nouvelle tâche',
                  child: const Icon(Icons.add),
                ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (store.error != null)
                TaskErrorBanner(
                  message: store.error!,
                  onRetry: store.load,
                  onDismiss: store.clearError,
                ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : tasks.isEmpty
                        ? _EmptyTasks(onCreate: () => _openForm(context))
                        : RefreshIndicator(
                            onRefresh: store.load,
                            child: ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              itemCount: tasks.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 8),
                              itemBuilder: (context, index) {
                                final task = tasks[index];
                                return TaskListTile(
                                  task: task,
                                  onTap: () => _openForm(context, task: task),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  const _EmptyTasks({required this.onCreate});

  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context) {
    return Center(
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
              'Appuyez sur + pour créer votre première tâche.',
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onCreate,
              icon: const Icon(Icons.add),
              label: const Text('Créer une tâche'),
            ),
          ],
        ),
      ),
    );
  }
}
