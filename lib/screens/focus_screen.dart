import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/screens/task_form_screen.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/task_error_banner.dart';
import 'package:taskflow/widgets/task_list_tile.dart';
import 'package:taskflow/widgets/task_store_scope.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = TaskStoreScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final tasks = store.focusTasks;

        return TaskFlowScaffold(
          title: 'Mode Focus',
          currentRoute: AppRoutes.focus,
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
                child: store.isLoading && store.tasks.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : tasks.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: AppColors.focusAccent
                                          .withValues(alpha: 0.12),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.center_focus_strong,
                                      size: 40,
                                      color: AppColors.focusAccent,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    'Rien à faire maintenant',
                                    style: AppTextStyles.headlineMedium,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Les tâches prioritaires ou dues aujourd\'hui apparaîtront ici.',
                                    style: AppTextStyles.bodyMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TaskFormScreen(
                                          taskStore: store,
                                          task: task,
                                        ),
                                      ),
                                    );
                                  },
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
