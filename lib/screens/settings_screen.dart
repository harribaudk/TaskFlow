import 'package:flutter/material.dart';
import 'package:taskflow/config/app_config.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/task_store_scope.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = TaskStoreScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final totalTasks = store.tasks.length;
        final focusTasks = store.focusTasks.length;

        return TaskFlowScaffold(
          title: 'Paramètres',
          currentRoute: AppRoutes.settings,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _SettingsCard(
                title: 'Raccourcis',
                child: Text(
                  'Utilisez les actions ci-dessous pour synchroniser et accéder rapidement à vos tâches.',
                  style: AppTextStyles.bodyMedium,
                ),
              ),
              const SizedBox(height: 12),
              _SettingsCard(
                title: 'État de l\'application',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _StatChip(label: 'Total', value: '$totalTasks'),
                        const SizedBox(width: 8),
                        _StatChip(label: 'Mode Focus', value: '$focusTasks'),
                        const SizedBox(width: 8),
                        _StatChip(
                          label: 'Sync',
                          value: store.isLoading ? 'chargement' : 'ok',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: store.isLoading ? null : store.load,
                            icon: const Icon(Icons.sync),
                            label: const Text('Synchroniser'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => Navigator.pushNamed(context, AppRoutes.tasks),
                            icon: const Icon(Icons.checklist),
                            label: const Text('Voir mes tâches'),
                          ),
                        ),
                      ],
                    ),
                    if (store.error != null) ...[
                      const SizedBox(height: 10),
                      Text(
                        store.error!,
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.error),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _SettingsCard(
                title: 'API REST',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppConfig.apiBaseUrl, style: AppTextStyles.titleMedium),
                    const SizedBox(height: 6),
                    Text(
                      'Démarrer le serveur : dart run tool/mock_task_api_server.dart',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.headlineMedium.copyWith(fontSize: 18)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.bodyMedium.copyWith(fontSize: 11)),
          const SizedBox(height: 2),
          Text(value, style: AppTextStyles.titleMedium),
        ],
      ),
    );
  }
}
