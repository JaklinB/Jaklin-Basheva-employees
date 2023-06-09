import 'package:employees/helpers/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/employee.dart';
import 'components/input_bottom_sheet.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(getPairWorkedLongest(getCommonProjects()),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          InkWell(
              onTap: () => showInputData(context, [
                          TableRow(
                            children: [
                              buildHeaderTableCell('EmpID'),
                              buildHeaderTableCell('ProjectID'),
                              buildHeaderTableCell('DateFrom'),
                              buildHeaderTableCell('DateTo'),
                            ],
                          ),
                          ...widget.employeeList.map((project) {
                            return TableRow(
                              children: [
                                buildTableCell(project.empId.toString()),
                                buildTableCell(project.projectId.toString()),
                                buildTableCell(DateFormat('dd MMM yyyy')
                                    .format(project.dateFrom)),
                                buildTableCell(DateFormat('dd MMM yyyy')
                                    .format(project.dateTo ?? DateTime.now())),
                              ],
                            );
                          }).toList(),
                        ],),
              child: Table(
                border: TableBorder.all(
                    width: 3, color: ThemeHelper.backgroundColor),
                children: [
                  TableRow(children: [
                    buildHeaderTableCell('Emp ID #1'),
                    buildHeaderTableCell('Emp ID #2'),
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
              )),
        ],
      ),
    );
  }

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
            DateTime start =
                projects[i].dateFrom.compareTo(projects[j].dateFrom) > 0
                    ? projects[i].dateFrom
                    : projects[j].dateFrom;
            DateTime? end =
                projects[i].dateTo != null && projects[j].dateTo != null
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

  String getPairWorkedLongest(List<Map<String, dynamic>> commonProjects) {
    Map<String, int> employeePairs = {};
    for (var project in commonProjects) {
      String empPair = '${project['empId1']}-${project['empId2']}';
      if (!employeePairs.containsKey(empPair)) {
        employeePairs[empPair] = 0;
      }
      employeePairs[empPair] =
          (employeePairs[empPair] ?? 0) + (project['daysWorked'] as int);
    }

    int maxTime = 0;
    List<String> maxPairs = [];
    for (var empPair in employeePairs.keys) {
      if (employeePairs[empPair]! > maxTime) {
        maxTime = employeePairs[empPair]!;
        maxPairs = [empPair];
      } else if (employeePairs[empPair] == maxTime) {
        maxPairs.add(empPair);
      }
    }

    if (maxPairs.length == 1) {
      if (maxTime == 0) {
        return 'No pair of employees worked together on any projects.';
      } else {
        List<String> empIds = maxPairs[0].split('-');
        return 'Employees ${empIds[0]} and ${empIds[1]} worked the most time together: $maxTime days';
      }
    } else if (maxPairs.length > 1) {
      List<String> pairMessages = [];
      for (var empPair in maxPairs) {
        if (employeePairs[empPair] == 0) {
          return 'No pair of employees worked together on any projects.';
        } else {
          List<String> empIds = empPair.split('-');
          pairMessages.add(
              'Employees ${empIds[0]} and ${empIds[1]}: ${employeePairs[empPair]} days');
        }
      }
      return 'There is more than one pair of employees that worked the most time together:\n${pairMessages.join('\n')}';
    } else {
      return 'No pair of employees worked together on any projects.';
    }
  }

  Widget buildHeaderTableCell(String text) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
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
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0),
            )));
  }

 
}
