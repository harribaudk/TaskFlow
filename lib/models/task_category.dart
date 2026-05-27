import 'package:flutter/material.dart';
import 'package:taskflow/theme/app_colors.dart';

enum TaskCategory {
  travail('Travail', Icons.work_outline, AppColors.primary),
  maison('Maison', Icons.home_outlined, AppColors.secondary),
  etudes('Études', Icons.school_outlined, AppColors.priorityLow),
  personnel('Personnel', Icons.person_outline, AppColors.priorityMedium);

  const TaskCategory(this.label, this.icon, this.color);

  final String label;
  final IconData icon;
  final Color color;
}
