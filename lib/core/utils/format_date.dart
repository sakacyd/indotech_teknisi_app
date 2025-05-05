import 'package:intl/intl.dart';

String formatDateByDMMMYYYY(DateTime date) {
  return DateFormat('d MMM, yyyy').format(date);
}

String formatDateByHm(DateTime date) {
  return DateFormat('H m').format(date);
}

String formatDateByEEEEddMMMM(DateTime date) {
  return  DateFormat('EEEE, dd MMMM').format(date);
}