import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/widgets/taskflow_scaffold.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const _previewCategories = [
    _CategoryPreview(name: 'Travail', icon: Icons.work_outline, color: AppColors.primary),
    _CategoryPreview(name: 'Maison', icon: Icons.home_outlined, color: AppColors.secondary),
    _CategoryPreview(name: 'Études', icon: Icons.school_outlined, color: AppColors.priorityLow),
    _CategoryPreview(name: 'Personnel', icon: Icons.person_outline, color: AppColors.priorityMedium),
  ];

  @override
  Widget build(BuildContext context) {
    return TaskFlowScaffold(
      title: 'Catégories',
      currentRoute: AppRoutes.categories,
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _previewCategories.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final category = _previewCategories[index];
          return Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: AppColors.border),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: category.color.withValues(alpha: 0.12),
                child: Icon(category.icon, color: category.color, size: 22),
              ),
              title: Text(category.name, style: AppTextStyles.titleMedium),
              trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class _CategoryPreview {
  const _CategoryPreview({
    required this.name,
    required this.icon,
    required this.color,
  });

  final String name;
  final IconData icon;
  final Color color;
}
