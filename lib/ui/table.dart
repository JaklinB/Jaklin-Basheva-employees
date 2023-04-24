import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';

import '../helpers/theme_helper.dart';
import '../models/employee.dart';

class TableLayout extends StatefulWidget {
  const TableLayout({super.key});

  @override
  State<TableLayout> createState() => _TableLayoutState();
}

class _TableLayoutState extends State<TableLayout> {
  List<List<dynamic>> data = List.empty(growable: true);
  List<Employee> employeeList = List.empty(growable: true);

  Future<void> loadAsset() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      List<int> bytes = await file.readAsBytes();
      List<List<dynamic>> csvTable =
          const CsvToListConverter(fieldDelimiter: ';')
              .convert(utf8.decode(bytes));
      print(csvTable);
      employeeList = List<Employee>.from(
        csvTable.sublist(1).map(
              (row) => Employee(
                empId: row[0],
                projectId: row[1],
                dateFrom: DateTime.parse(row[2]),
                dateTo:
                    row[3] != null ? DateTime.tryParse(row[3]) : DateTime.now(),
              ),
            ),
      );
      setState(() {
        data = csvTable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          backgroundColor: ThemeHelper.backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
        onPressed: () async {
          await loadAsset();
        },
        icon: const Icon(
          Icons.upload,
          size: 30,
        ),
        label: const Text("Upload",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
      ),
      appBar: AppBar(
        backgroundColor: ThemeHelper.backgroundColor,
        title: const Text('Employees', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25)),
      ),
      body: SingleChildScrollView(
        child: data.isNotEmpty
            ? Table(
                columnWidths: const {
                  0: FixedColumnWidth(100.0),
                  1: FixedColumnWidth(100.0),
                  2: FixedColumnWidth(100.0),
                  3: FixedColumnWidth(100.0),
                },
                border: TableBorder.all(width: 1.0),
                children: [
                  TableRow(
                    children: data.first.map((header) {
                      return TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            header.toString(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  ...employeeList.map((item) {
                    return TableRow(children: [
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.empId.toString(),
                                style: const TextStyle(fontSize: 20.0),
                              ))),
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.projectId.toString(),
                                style: const TextStyle(fontSize: 20.0),
                              ))),
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.dateFrom.toString(),
                                style: const TextStyle(fontSize: 20.0),
                              ))),
                      TableCell(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.dateTo.toString(),
                                style: const TextStyle(fontSize: 20.0),
                              )))
                    ]);
                  }).toList(),
                ],
              )
            : Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const Text("Please load a CSV file.",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 20),
                    const Text("The file should have the following format:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400)),
                    const SizedBox(height: 10),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: const [
                        ListTile(
                          title: Text('EmpID'),
                          leading: Icon(Icons.person),
                          trailing: Text('Employee ID'),
                        ),
                        ListTile(
                          title: Text('ProjectID'),
                          leading: Icon(Icons.work),
                          trailing: Text('Project ID'),
                        ),
                        ListTile(
                          title: Text('DateFrom'),
                          leading: Icon(Icons.date_range),
                          trailing: Text('Starting date'),
                        ),
                        ListTile(
                          title: Text('DateTo'),
                          leading: Icon(Icons.date_range_outlined),
                          trailing: Text('Ending date'),
                        ),
                      ],
                    )
                  ],
                )),
      ),
    );
  }
}
