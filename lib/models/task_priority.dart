import 'package:flutter/material.dart';
import 'package:taskflow/theme/app_colors.dart';

enum TaskPriority {
  low('Basse', AppColors.priorityLow),
  medium('Moyenne', AppColors.priorityMedium),
  high('Haute', AppColors.priorityHigh);

  const TaskPriority(this.label, this.color);

  final String label;
  final Color color;
}
