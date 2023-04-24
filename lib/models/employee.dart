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

  static final List<String> dateFormats = [
    'yyyy-MM-dd',
    'dd/MM/yyyy',
    'MM/dd/yyyy',
    'yyyy/MM/dd',
    'dd-MMM-yyyy',
    'MMM dd, yyyy',
    'dd MMMM yyyy',
    'yyyy-MM-dd HH:mm:ss',
    'MM/dd/yyyy HH:mm:ss',
    'yyyy/MM/dd HH:mm:ss',
    'dd-MMM-yyyy HH:mm:ss',
    'MMM dd, yyyy HH:mm:ss',
    'dd MMMM yyyy HH:mm:ss',
    'd MMMM yyyy',
    'd MMM yyyy',
    'dd MMM yyyy',
    'dd MMMM yy',
    'd/M/yyyy',
    'd/M/yy',
    'd-M-yyyy',
    'd-M-yy',
    'd/MMM/yyyy',
    'd-MMM-yyyy',
    'd-MMM-yy',
    'MMM yyyy',
    'MMM. yyyy',
    'MMM, yyyy',
    'MMM dd yyyy',
    'dd MMM yyyy',
    'dd-MMM-yy',
    'dd-MMM-yyyy',
    'dd MMM yy',
    'dd MMM yyyy',
    'dd/MMM/yyyy',
    'dd/MMM/yy',
    'dd/MM/yyyy',
    'dd/M/yyyy',
    'M/dd/yyyy',
    'M/dd/yy',
    'M/d/yyyy',
    'M/d/yy',
    'MMM dd, yyyy',
    'MMMM dd, yyyy',
    'MMM. dd, yyyy',
    'MMMM. dd, yyyy',
    'MMMM d, yyyy',
    'MMM d, yyyy',
    'MMMM d yyyy',
    'MMM d yyyy',
    'dd MMM yy',
    'dd MMMM yy',
    'd MMM yy',
    'd MMMM yy',
    'd MMM yyyy',
    'd MMMM yyyy',
    'd-MMM-yy',
    'd-MMM-yyyy',
    'd/M/yy',
    'd/M/yyyy',
    'dd-M-yy',
    'dd-M-yyyy',
    'dd/MM/yy',
    'dd/MM/yyyy',
    'dd/MMM/yy',
    'd MMM yy',
    'dd MMM yy',
    'dd MMMM yyyy',
    'd MMMM, yyyy',
    'dd/MM/yy',
    'dd-MMM-yyyy',
    'dd/MMM/yyyy',
    'dd/MM/yyyy HH:mm',
    'yyyy-MM-ddTHH:mm:ssZ',
    'yyyy-MM-ddTHH:mm:ss.SSSZ',
    'MMM dd, yyyy HH:mm:ss a',
    'MMMM dd, yyyy HH:mm:ss a',
    'yyyy/MM/dd HH:mm:ss',
    'MM/dd/yyyy HH:mm:ss',
    'dd-MMM-yyyy HH:mm:ss',
    'dd MMM yyyy HH:mm:ss',
    'd MMMM yyyy HH:mm:ss',
    'MMM dd, yyyy HH:mm:ss',
    'dd/MM/yyyy HH:mm:ss',
    'd/M/yyyy HH:mm:ss',
    'yyyy-MM-dd HH:mm:ss',
    'yyyy/MM/dd HH:mm:ss',
    'yyyy.MM.dd',
    'dd.MM.yyyy',
    'yyyy.MM',
    'MMM yyyy',
    'yyyy.MM.dd HH:mm',
    'yyyy-MM-ddTHH:mm:ss.SSS',
    'yyyy-MM-ddTHH:mm:ss',
    'yyyy/MM/dd',
    'yyyy/MM',
    'yyyy',
    'MMMM',
    'MMM',
    'dd',
    'd',
    'yyyy'
  ];

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
    for (final format in dateFormats) {
      try {
        return DateFormat(format).parse(dateStr);
      } catch (e) {}
    }
    throw Exception('Invalid date format: $dateStr');
  }
}
