import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';
import 'package:taskflow/widgets/taskflow_text_field.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskFlowScaffold(
      title: 'Paramètres',
      currentRoute: AppRoutes.settings,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text('Aperçu des composants', style: AppTextStyles.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'Champs et boutons réutilisables de la charte graphique.',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 24),
          const TaskFlowTextField(
            label: 'Exemple de champ',
            hint: 'Saisir une valeur…',
          ),
          const SizedBox(height: 16),
          const TaskFlowTextField(
            label: 'Recherche',
            hint: 'Rechercher une tâche…',
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Charte graphique', style: AppTextStyles.titleMedium),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _ColorSwatch(color: AppColors.primary, label: 'Primary'),
                    _ColorSwatch(color: AppColors.secondary, label: 'Secondary'),
                    _ColorSwatch(color: AppColors.focusAccent, label: 'Focus'),
                    _ColorSwatch(color: AppColors.priorityHigh, label: 'Haute'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: AppTextStyles.bodyMedium.copyWith(fontSize: 11)),
      ],
    );
  }
}
