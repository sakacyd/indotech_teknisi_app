import 'package:intl/intl.dart';

String formatDateByDMMMYYYY(DateTime date) {
  return DateFormat('d MMM, yyyy').format(date);
}

String formatDateByHm(DateTime date) {
  return DateFormat('HH:mm').format(date);
}

String formatDateByEEEEddMMMM(DateTime date) {
  return  DateFormat('EEEE, dd MMMM', 'id_ID').format(date);
}

String formatDateByddMMMMyyyy(DateTime date) {
  return  DateFormat('dd MMMM yyyy').format(date);
}