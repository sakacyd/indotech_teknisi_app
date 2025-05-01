import 'package:intl/intl.dart';

String formatDateByDMMMYYYY(DateTime date) {
  return DateFormat('d MMM, yyyy').format(date);
}

String formatDateByHm(DateTime date) {
  return DateFormat('H m').format(date);
}