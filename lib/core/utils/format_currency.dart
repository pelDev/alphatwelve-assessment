import 'package:intl/intl.dart';

String formatCurrency(double amount, String currencyCode) {
  final format = NumberFormat.simpleCurrency(name: currencyCode);
  return format.format(amount);
}
