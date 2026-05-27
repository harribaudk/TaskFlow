import 'package:flutter/material.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';

class TaskErrorBanner extends StatelessWidget {
  const TaskErrorBanner({
    super.key,
    required this.message,
    required this.onRetry,
    this.onDismiss,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.error.withValues(alpha: 0.08),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.error_outline, color: AppColors.error, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
            TextButton(
              onPressed: onRetry,
              child: const Text('Réessayer'),
            ),
            if (onDismiss != null)
              IconButton(
                onPressed: onDismiss,
                icon: const Icon(Icons.close, size: 18),
                color: AppColors.textSecondary,
              ),
          ],
        ),
      ),
    );
  }
}
