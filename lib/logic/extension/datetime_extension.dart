import 'package:fam_coding_supply/fam_coding_supply.dart';

extension DateTimeExtensions on DateTime {
  // Format date to string
  String format([String pattern = 'yyyy-MM-dd']) {
    return DateFormat(pattern).format(this);
  }

  // Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  // Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  // Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  // Add duration to date and return new instance
  DateTime addTime({int days = 0, int hours = 0, int minutes = 0, int seconds = 0}) {
    return add(Duration(days: days, hours: hours, minutes: minutes, seconds: seconds));
  }

  // Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  // Get end of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  // Get difference in days from another date
  int daysDifference(DateTime other) => (difference(other).inDays.abs());

  // Get age from birth date
  int get age {
    final now = DateTime.now();
    int years = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      years--;
    }
    return years;
  }

  // Check if date is between two other dates
  bool isBetween(DateTime from, DateTime to) => isAfter(from) && isBefore(to);
}
