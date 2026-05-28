import 'package:flutter/material.dart';
import 'package:taskflow/routes/app_routes.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';

class TaskFlowDrawer extends StatelessWidget {
  const TaskFlowDrawer({super.key, required this.currentRoute});

  final String currentRoute;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DrawerHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _DrawerTile(
                    icon: Icons.home_outlined,
                    selectedIcon: Icons.home,
                    label: 'Accueil',
                    route: AppRoutes.home,
                    currentRoute: currentRoute,
                  ),
                  _DrawerTile(
                    icon: Icons.check_circle_outline,
                    selectedIcon: Icons.check_circle,
                    label: 'Mes tâches',
                    route: AppRoutes.tasks,
                    currentRoute: currentRoute,
                  ),
                  _DrawerTile(
                    icon: Icons.center_focus_strong_outlined,
                    selectedIcon: Icons.center_focus_strong,
                    label: 'Mode Focus',
                    route: AppRoutes.focus,
                    currentRoute: currentRoute,
                  ),
                  const Divider(height: 24, indent: 16, endIndent: 16),
                  _DrawerTile(
                    icon: Icons.settings_outlined,
                    selectedIcon: Icons.settings,
                    label: 'Paramètres',
                    route: AppRoutes.settings,
                    currentRoute: currentRoute,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.task_alt,
              color: AppColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text('TaskFlow', style: AppTextStyles.displayLarge.copyWith(fontSize: 22)),
          const SizedBox(height: 4),
          Text(
            'Organisez votre journée',
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.route,
    required this.currentRoute,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String route;
  final String currentRoute;

  bool get _selected => currentRoute == route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        _selected ? selectedIcon : icon,
        color: _selected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(
        label,
        style: AppTextStyles.titleMedium.copyWith(
          color: _selected ? AppColors.primary : AppColors.textPrimary,
          fontWeight: _selected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      selected: _selected,
      selectedTileColor: AppColors.primary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: () {
        Navigator.pop(context);
        if (!_selected) {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}
