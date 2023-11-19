import 'package:intl/intl.dart';

String determineTaskStatus(String formattedDate, bool status) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
  final DateTime taskDateTime = formatter.parse(formattedDate);
  final DateTime currentDateTime = DateTime.now();

  if (status) {
    return 'completed';
  } else if (taskDateTime.isBefore(currentDateTime)) {
    return 'pending';
  } else {
    return 'doing';
  }
}
