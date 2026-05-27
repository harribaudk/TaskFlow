const _monthLabels = [
  'janvier',
  'février',
  'mars',
  'avril',
  'mai',
  'juin',
  'juillet',
  'août',
  'septembre',
  'octobre',
  'novembre',
  'décembre',
];

String formatTaskDeadline(DateTime dateTime, {required bool includesTime}) {
  final date =
      '${dateTime.day} ${_monthLabels[dateTime.month - 1]} ${dateTime.year}';
  if (!includesTime) return date;
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  return '$date à $hour:$minute';
}
