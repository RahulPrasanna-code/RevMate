import 'package:intl/intl.dart';

DateTime? parseIndianDate(String? input) {
  if (input == null) return null;
  input = input.trim();
  if (input.isEmpty) return null;

  // Try ISO yyyy-MM-dd
  try {
    final iso = DateTime.tryParse(input);
    if (iso != null) return iso;
  } catch (_) {}

  final formats = [
    DateFormat('dd-MMM-yyyy'),
    DateFormat('dd/MM/yyyy'),
    DateFormat('dd-MM-yyyy'),
    DateFormat('MMM yyyy'),
    DateFormat('MM/yyyy'),
  ];

  for (final fmt in formats) {
    try {
      final dt = fmt.parseLoose(input);
      if (fmt.pattern == 'MMM yyyy') {
        // return last day of month
        final next = DateTime(dt.year, dt.month + 1, 1);
        return next.subtract(const Duration(days: 1));
      }
      return dt;
    } catch (_) {}
  }

  return null;
}
