import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/taskflow_button.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskFlowScaffold(
      title: 'Accueil',
      currentRoute: AppRoutes.home,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Bonjour 👋', style: AppTextStyles.displayLarge),
            const SizedBox(height: 8),
            Text(
              'TaskFlow vous aide à organiser vos journées de façon simple et agréable.',
              style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            _FeatureCard(
              icon: Icons.check_circle_outline,
              color: AppColors.primary,
              title: 'Créer des tâches',
              description: 'Ajoutez vos tâches avec priorités et deadlines.',
            ),
            const SizedBox(height: 12),
            _FeatureCard(
              icon: Icons.folder_outlined,
              color: AppColors.priorityLow,
              title: 'Catégories',
              description: 'Classez par travail, maison, études…',
            ),
            const SizedBox(height: 12),
            _FeatureCard(
              icon: Icons.center_focus_strong_outlined,
              color: AppColors.focusAccent,
              title: 'Mode Focus',
              description: 'Affichez uniquement ce qui doit être fait maintenant.',
            ),
            const SizedBox(height: 32),
            TaskFlowButton(
              label: 'Voir mes tâches',
              icon: Icons.arrow_forward,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.tasks),
            ),
            const SizedBox(height: 12),
            TaskFlowButton(
              label: 'Mode Focus',
              variant: TaskFlowButtonVariant.outlined,
              icon: Icons.center_focus_strong,
              onPressed: () => Navigator.pushNamed(context, AppRoutes.focus),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color color;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleMedium),
                  const SizedBox(height: 4),
                  Text(description, style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
