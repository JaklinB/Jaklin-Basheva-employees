import 'package:employees/helpers/date_helper.dart';
import 'package:intl/intl.dart';

class Employee {
  final int empId;
  final int projectId;
  final DateTime dateFrom;
  final DateTime? dateTo;

  Employee({
    required this.empId,
    required this.projectId,
    required this.dateFrom,
    this.dateTo,
  });

  factory Employee.fromCsv(String csv) {
    final values = csv.split(';');
    final empId = int.parse(values[0]);
    final projectId = int.parse(values[1]);
    final dateFrom = _parseDate(values[2]);
    final dateTo = values[3] != 'NULL' ? _parseDate(values[3]) : null;
    return Employee(
      empId: empId,
      projectId: projectId,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }

  static DateTime _parseDate(String dateStr) {
    for (final format in DateHelper.dateFormats) {
      try {
        return DateFormat(format).parse(dateStr);
      } catch (e) {
       // print(e);
      }
    }
    throw Exception('Invalid date format: $dateStr');
  }
}
