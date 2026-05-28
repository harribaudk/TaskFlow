import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_priority.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/utils/date_format.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.task,
    required this.onTap,
  });

  final Task task;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final deadline = task.deadline;
    final hasTime = deadline != null && (deadline.hour != 0 || deadline.minute != 0);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        onTap: onTap,
        leading: _TaskLeading(task: task),
        title: Text(
          task.title,
          style: AppTextStyles.titleMedium.copyWith(
            decoration: task.completed ? TextDecoration.lineThrough : null,
            color: task.completed ? AppColors.textSecondary : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description != null && task.description!.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                task.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium,
              ),
            ],
            const SizedBox(height: 6),
            Row(
              children: [
                _PriorityBadge(priority: task.priority),
                if (deadline != null) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.schedule,
                    size: 14,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      formatTaskDeadline(deadline, includesTime: hasTime),
                      style: AppTextStyles.bodyMedium.copyWith(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      ),
    );
  }
}

class _TaskLeading extends StatelessWidget {
  const _TaskLeading({required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final photoPath = task.photoPath;
    if (photoPath != null && photoPath.isNotEmpty) {
      final file = File(photoPath);
      if (file.existsSync()) {
        return CircleAvatar(
          backgroundImage: FileImage(file),
        );
      }
    }

    return CircleAvatar(
      backgroundColor: task.category.color.withValues(alpha: 0.12),
      child: Icon(task.category.icon, color: task.category.color, size: 22),
    );
  }
}

class _PriorityBadge extends StatelessWidget {
  const _PriorityBadge({required this.priority});

  final TaskPriority priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: priority.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        priority.label,
        style: AppTextStyles.labelLarge.copyWith(
          fontSize: 11,
          color: priority.color,
        ),
      ),
    );
  }
}
