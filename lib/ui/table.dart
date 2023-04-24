import 'package:flutter/material.dart';

import '../models/employee.dart';

class TableLayout extends StatefulWidget {
  final List<Employee> employeeList;
  final List<List<dynamic>> data;
  const TableLayout(
      {super.key, required this.employeeList, required this.data});

  @override
  State<TableLayout> createState() => _TableLayoutState();
}

class _TableLayoutState extends State<TableLayout> {
  @override
  Widget build(BuildContext context) {
    return Table(
      // columnWidths: const {
      //   0: FixedColumnWidth(90),
      //   1: FixedColumnWidth(110),
      //   2: FixedColumnWidth(120),
      //   3: FixedColumnWidth(120),
      // },
      border: TableBorder.all(width: 1.0),
      children: [
        TableRow(
          children: widget.data.first.map((header) {
            return TableCell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  header.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        ...widget.employeeList.map((item) {
          return TableRow(children: [
            buildTableCell(item.empId.toString()),
            buildTableCell(item.projectId.toString()),
            buildTableCell(item.dateFrom.toString()),
            buildTableCell(item.dateTo.toString()),
          ]);
        }).toList(),
      ],
    );
  }

  Widget buildTableCell(String text) {
    return TableCell(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: const TextStyle(fontSize: 20.0),
            )));
  }
}
