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

  factory Employee.fromCsv(List<dynamic> row) {
    return Employee(
      empId: row[0],
      projectId: row[1],
      dateFrom: DateTime.parse(row[2]),
      dateTo: row[3] == 'NULL' ? DateTime.now() : DateTime.parse(row[3]),
    );
  }
}
