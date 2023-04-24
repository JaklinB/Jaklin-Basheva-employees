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
 List<Map<String, dynamic>> getCommonProjects() {
  List<Map<String, dynamic>> commonProjects = [];

  // Group project data by project ID
  Map<int, List<Employee>> projectGroups = {};
  for (var project in widget.employeeList) {
    if (!projectGroups.containsKey(project.projectId)) {
      projectGroups[project.projectId] = [];
    }
    projectGroups[project.projectId]!.add(project);
  }

  for (var projectId in projectGroups.keys) {
    List<Employee> projects = projectGroups[projectId]!;
    for (var i = 0; i < projects.length - 1; i++) {
      for (var j = i + 1; j < projects.length; j++) {
        if (projects[i].empId != projects[j].empId) {
          int daysWorked = 0;
          DateTime start = projects[i].dateFrom.compareTo(projects[j].dateFrom) > 0
              ? projects[i].dateFrom
              : projects[j].dateFrom;
          DateTime? end = projects[i].dateTo != null && projects[j].dateTo != null
              ? projects[i].dateTo!.compareTo(projects[j].dateTo!) > 0
                  ? projects[j].dateTo
                  : projects[i].dateTo
              : projects[i].dateTo ?? projects[j].dateTo;

          if (end != null) {
            daysWorked = end.difference(start).inDays;
          }

          commonProjects.add({
            'empId1': projects[i].empId,
            'empId2': projects[j].empId,
            'projectId': projectId,
            'daysWorked': daysWorked < 0 ? 0 : daysWorked,
          });
        }
      }
    }
  }

  return commonProjects;
}

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(width: 1.0),
      children: [
        TableRow(children: [
          buildHeaderTableCell('Employee ID #1'),
          buildHeaderTableCell('Employee ID #2'),
          buildHeaderTableCell('Project ID'),
          buildHeaderTableCell('Days worked'),
        ]),
        ...getCommonProjects().map((project) {
          return TableRow(children: [
            buildTableCell(project['empId1'].toString()),
            buildTableCell(project['empId2'].toString()),
            buildTableCell(project['projectId'].toString()),
            buildTableCell(project['daysWorked'].toString()),
          ]);
        }).toList(),
      ],
    );
  }

  Widget buildHeaderTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
