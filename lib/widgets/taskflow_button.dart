import 'package:flutter/material.dart';

enum TaskFlowButtonVariant { primary, outlined }

class TaskFlowButton extends StatelessWidget {
  const TaskFlowButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = TaskFlowButtonVariant.primary,
    this.icon,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final TaskFlowButtonVariant variant;
  final IconData? icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final child = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Text(label),
            ],
          )
        : Text(label);

    final callback = enabled ? onPressed : null;

    return switch (variant) {
      TaskFlowButtonVariant.primary => ElevatedButton(
          onPressed: callback,
          child: child,
        ),
      TaskFlowButtonVariant.outlined => OutlinedButton(
          onPressed: callback,
          child: child,
        ),
    };
  }
}
