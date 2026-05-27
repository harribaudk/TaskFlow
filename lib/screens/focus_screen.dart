import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskFlowScaffold(
      title: 'Mode Focus',
      currentRoute: AppRoutes.focus,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.focusAccent.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.center_focus_strong,
                  size: 40,
                  color: AppColors.focusAccent,
                ),
              ),
              const SizedBox(height: 24),
              Text('Rien à faire maintenant', style: AppTextStyles.headlineMedium),
              const SizedBox(height: 8),
              Text(
                'Ici s\'afficheront uniquement les tâches urgentes ou prévues pour maintenant.',
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
