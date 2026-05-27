import 'package:flutter/material.dart';
import 'package:taskflow/data/task_store.dart';
import 'package:taskflow/models/task.dart';
import 'package:taskflow/models/task_category.dart';
import 'package:taskflow/models/task_priority.dart';
import 'package:taskflow/theme/app_colors.dart';
import 'package:taskflow/theme/app_text_styles.dart';
import 'package:taskflow/utils/date_format.dart';
import 'package:taskflow/widgets/selection_chip.dart';
import 'package:taskflow/widgets/taskflow_button.dart';
import 'package:taskflow/widgets/taskflow_text_field.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({
    super.key,
    required this.taskStore,
    this.task,
  });

  final TaskStore taskStore;
  final Task? task;

  bool get isEditing => task != null;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}

class _TaskFormScreenState extends State<TaskFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  late TaskCategory _category;
  late TaskPriority _priority;
  DateTime? _deadline;
  bool _deadlineHasTime = false;

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    _titleController = TextEditingController(text: task?.title ?? '');
    _descriptionController = TextEditingController(text: task?.description ?? '');
    _category = task?.category ?? TaskCategory.travail;
    _priority = task?.priority ?? TaskPriority.medium;
    _deadline = task?.deadline;
    if (_deadline != null) {
      _deadlineHasTime =
          _deadline!.hour != 0 || _deadline!.minute != 0;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDeadline() async {
    final now = DateTime.now();
    final initialDate = _deadline ?? now;
    final date = await showDatePicker(
      context: context,
      initialDate: initialDate.isBefore(now) ? now : initialDate,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365 * 5)),
      locale: const Locale('fr', 'FR'),
      helpText: 'Choisir une date',
      cancelText: 'Annuler',
      confirmText: 'Valider',
    );
    if (date == null || !mounted) return;

    DateTime result = DateTime(date.year, date.month, date.day);
    if (_deadlineHasTime) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_deadline ?? now),
        helpText: 'Choisir une heure',
        cancelText: 'Annuler',
        confirmText: 'Valider',
      );
      if (time == null || !mounted) return;
      result = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    }

    setState(() => _deadline = result);
  }

  void _clearDeadline() {
    setState(() {
      _deadline = null;
      _deadlineHasTime = false;
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (widget.isEditing) {
      widget.taskStore.update(
        widget.task!.copyWith(
          title: title,
          description: description.isEmpty ? null : description,
          clearDescription: description.isEmpty,
          category: _category,
          priority: _priority,
          deadline: _deadline,
          clearDeadline: _deadline == null,
        ),
      );
    } else {
      widget.taskStore.add(
        Task(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          title: title,
          description: description.isEmpty ? null : description,
          category: _category,
          priority: _priority,
          deadline: _deadline,
        ),
      );
    }

    Navigator.pop(context, true);
  }

  void _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer la tâche ?'),
        content: const Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;
    widget.taskStore.remove(widget.task!.id);
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? 'Modifier la tâche' : 'Nouvelle tâche'),
        actions: [
          if (widget.isEditing)
            IconButton(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline),
              color: AppColors.error,
              tooltip: 'Supprimer',
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                children: [
            const _SectionLabel('Informations'),
            const SizedBox(height: 12),
            TaskFlowTextField(
              label: 'Titre',
              hint: 'Ex. Préparer la réunion',
              controller: _titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Le titre est obligatoire';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TaskFlowTextField(
              label: 'Description',
              hint: 'Détails optionnels…',
              controller: _descriptionController,
              maxLines: 4,
            ),
            const SizedBox(height: 28),
            const _SectionLabel('Catégorie'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TaskCategory.values.map((category) {
                return SelectionChip(
                  label: category.label,
                  selected: _category == category,
                  selectedColor: category.color,
                  leading: Icon(
                    category.icon,
                    size: 18,
                    color: _category == category
                        ? category.color
                        : AppColors.textSecondary,
                  ),
                  onSelected: () => setState(() => _category = category),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
            const _SectionLabel('Priorité'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: TaskPriority.values.map((priority) {
                return SelectionChip(
                  label: priority.label,
                  selected: _priority == priority,
                  selectedColor: priority.color,
                  onSelected: () => setState(() => _priority = priority),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),
            const _SectionLabel('Échéance'),
            const SizedBox(height: 12),
            _DeadlinePicker(
              deadline: _deadline,
              hasTime: _deadlineHasTime,
              onPick: _pickDeadline,
              onClear: _clearDeadline,
              onToggleTime: (value) {
                setState(() {
                  _deadlineHasTime = value;
                  if (_deadline != null && !value) {
                    final d = _deadline!;
                    _deadline = DateTime(d.year, d.month, d.day);
                  }
                });
              },
            ),
                ],
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TaskFlowButton(
                      key: const Key('task_form_save'),
                      label: widget.isEditing ? 'Enregistrer' : 'Créer la tâche',
                      icon: Icons.check,
                      onPressed: _save,
                    ),
                    if (widget.isEditing) ...[
                      const SizedBox(height: 12),
                      TaskFlowButton(
                        label: 'Annuler',
                        variant: TaskFlowButtonVariant.outlined,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.titleMedium);
  }
}

class _DeadlinePicker extends StatelessWidget {
  const _DeadlinePicker({
    required this.deadline,
    required this.hasTime,
    required this.onPick,
    required this.onClear,
    required this.onToggleTime,
  });

  final DateTime? deadline;
  final bool hasTime;
  final VoidCallback onPick;
  final VoidCallback onClear;
  final ValueChanged<bool> onToggleTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onPick,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.event_outlined,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      deadline != null
                          ? formatTaskDeadline(deadline!, includesTime: hasTime)
                          : 'Ajouter une date limite',
                      style: AppTextStyles.bodyLarge.copyWith(
                        color: deadline != null
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.textSecondary.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (deadline != null) ...[
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Inclure une heure', style: AppTextStyles.bodyLarge),
            value: hasTime,
            onChanged: onToggleTime,
            activeThumbColor: AppColors.primary,
          ),
          TextButton.icon(
            onPressed: onClear,
            icon: const Icon(Icons.clear, size: 18),
            label: const Text('Retirer l\'échéance'),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
          ),
        ],
      ],
    );
  }
}
