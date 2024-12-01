import 'package:intl/intl.dart';

class AppCurrencyUtilsCS {
  static String format(double value) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(value);
  }
}
